import Foundation

public protocol Showable {
    
    /// The showable type.
    var showableType: ShowableType { get }
    
    /// The amount of time in seconds to wait between shows.
    var minimumTimeBetweenShows: TimeInterval { get }
    
    /// The minimum amount of seconds since the first time the show request is made that the item can be shown.
    /// For example, if the first request is made on Day 0, and the minimum time is 24 hours, `canShow()` will always return false until Day 1.
    var minimumTimeSinceFirstShowRequest: TimeInterval { get }
    
    /// Handle showing whatever you want to show.
    func show(_ sender: Any?)
    
    /// The next date to show the item on.
    /// - Returns: The date.
    func nextShowAt() -> Date?
    
    /// The date that the item was last shown at.
    /// - Returns: The date.
    func lastShownAt() -> Date?
    
    /// The date that the item was first requested if it can be shown at.
    /// - Returns: The date.
    func firstShowRequestedAt() -> Date?
    
    /// Whether showing is currently blocked.
    func isShowingBlocked() -> Bool
    
    /// Sets the next date to show the item at.
    /// - Parameter date: The date.
    func setNextShowAt(_ date: Date?)
    
    /// Set the date that the item was last shown at.
    /// - Parameter date: The date.
    func setLastShownAt(_ date: Date?)
    
    /// Sets the first show requested at the given date.
    /// - Parameter date: The date.
    func setFirstShownAt(_ date: Date?)
    
    /// Prevents or enables future shows.
    /// - Parameter block: Boolean.
    func setBlockEnabled(_ block: Bool)
    
}

