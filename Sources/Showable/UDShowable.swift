
import Foundation

/// Extension of Showable that conveniently uses UserDefaults to store data.
public protocol UDShowable: Showable {
    /// The user defaults key for showable.
    var showableBaseKey: String { get }
    
    /// Use your own logic to decide whether to always block the item being shown.
    /// For example, return true if the user is subscribed and you want to show the subscription page.
    /// - Returns: Boolean
    func alwaysBlockShowing() -> Bool
}

public extension UDShowable {
    private var lastShownAtKey: String {
        showableBaseKey + "_LastShownAt"
    }
    
    private var firstShowRequestedAtKey: String {
        showableBaseKey + "_FirstShowRequestedAt"
    }
    
    private var nextShowAtKey: String {
        showableBaseKey + "_NextShowAt"
    }
    
    private var blockedKey: String {
        showableBaseKey + "_Blocked"
    }
    
    /// Sets the next date to show the item at.
    /// - Parameter date: The date.
    func setNextShowAt(_ date: Date?) {
        UserDefaults.standard.set(date, forKey: nextShowAtKey)
        UserDefaults.standard.synchronize()
    }
    
    /// The next date to show the item on.
    /// - Returns: The date.
    func nextShowAt() -> Date? {
        UserDefaults.standard.object(forKey: nextShowAtKey) as? Date
    }
    
    /// Sets the date that the item was last shown at.
    /// - Parameter date: The last shown at date.
    func setLastShownAt(_ date: Date?) {
        UserDefaults.standard.set(date, forKey: lastShownAtKey)
        UserDefaults.standard.synchronize()
    }
    
    /// The date that the item was last shown at.
    /// - Returns: The date.
    func lastShownAt() -> Date? {
        UserDefaults.standard.object(forKey: lastShownAtKey) as? Date
    }
    
    /// The date that the item was first shown at.
    /// - Returns: The date.
    func firstShowRequestedAt() -> Date? {
        UserDefaults.standard.object(forKey: firstShowRequestedAtKey) as? Date
    }
    
    /// Sets the first show requested at the given date.
    /// - Parameter date: The date.
    func setFirstShowRequestedAt(_ date: Date?) {
        UserDefaults.standard.set(date, forKey: firstShowRequestedAtKey)
        UserDefaults.standard.synchronize()
    }


    /// Whether showing is blocked.
    func isShowingBlocked() -> Bool {
        alwaysBlockShowing() || UserDefaults.standard.bool(forKey: blockedKey)
    }
    
    /// Prevents or enables future shows.
    /// - Parameter block: Boolean.
    func setBlockEnabled(_ block: Bool) {
        UserDefaults.standard.set(block, forKey: blockedKey)
        UserDefaults.standard.synchronize()
    }
}
