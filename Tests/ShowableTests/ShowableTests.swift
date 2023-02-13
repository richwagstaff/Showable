import XCTest
@testable import Showable

final class ShowableTests: XCTestCase {
    
    func testCanShow() throws {
        
        let showable = ShowableTestClass()
        showable.minimumTimeBetweenShows = 60
        showable.resetShowable()
        
        XCTAssertTrue(showable.canShow())
        
        showable.didShow()
        XCTAssertFalse(showable.canShow())

        showable.setLastShownAt(Date().addingTimeInterval(-70))
        XCTAssertTrue(showable.canShow())
        
        XCTAssertTrue(showable.canShow(willShowImmediately: true))
        XCTAssertFalse(showable.canShow(willShowImmediately: true))
        
    }
    
    func testTimeSinceFirstShowRequest() throws {
        
        let showable = ShowableTestClass()
        showable.minimumTimeBetweenShows = 60
        showable.minimumTimeSinceFirstShowRequest = 60
        showable.resetShowable()
        
        XCTAssertFalse(showable.canShow())
        
        showable.setFirstShownAt(Date().addingTimeInterval(-70))
        XCTAssertTrue(showable.canShow())
        
        showable.setLastShownAt(Date())
        XCTAssertFalse(showable.canShow())
        
        showable.setLastShownAt(Date().addingTimeInterval(-61))
        XCTAssertTrue(showable.canShow())
        
    }
    
    func testAlwaysBlockUDShowable() throws {
        
        let showable = ShowableTestClass()
        showable.minimumTimeBetweenShows = 60
        showable.alwaysBlockTestValue = true
        showable.resetShowable()
        
        XCTAssertFalse(showable.canShow())
        
        showable.alwaysBlockTestValue = false
        XCTAssertTrue(showable.canShow())
        
        showable.minimumTimeSinceFirstShowRequest = 60
        XCTAssertFalse(showable.canShow())
        
        showable.minimumTimeSinceFirstShowRequest = 0
        showable.didShow()
        XCTAssertFalse(showable.canShow())
        
    }
    
    func testDateShowable() {
        let showable = ShowableTestClass()
        showable.resetShowable()
        
        showable.showableType = .date
        showable.showAgainTomorrow()
        XCTAssertFalse(showable.canShow())

        showable.setNextShowIn(days: -2)
        XCTAssertTrue(showable.canShow(willShowImmediately: true))
        XCTAssertFalse(showable.canShow())

    }
    
    func testBlocking() {
        let showable = ShowableTestClass()
        showable.minimumTimeBetweenShows = 60
        showable.resetShowable()
        
        showable.setLastShownAt(Date().addingTimeInterval(-24*60*60))
        showable.blockShowing()
        XCTAssertFalse(showable.canShow())
        
        showable.enableShowing()
        XCTAssertTrue(showable.canShow())
    }


}

fileprivate class ShowableTestClass: UDShowable {
    
    var showableType: ShowableType = .schedule
    
    var showableBaseKey: String = "ShowableTest"
    
    var minimumTimeBetweenShows: TimeInterval = 0
    
    var minimumTimeSinceFirstShowRequest: TimeInterval = 0
    
    var alwaysBlockTestValue: Bool = false
    
    func show(_ sender: Any?) {
        
    }
    
    
    func alwaysBlockShowing() -> Bool {
        alwaysBlockTestValue
    }
    
}
