
import Foundation

public extension Showable {
    /// Sets the date to next show the item at.
    /// - Parameters:
    ///   - component: The date component.
    ///   - value: The value.
    func setNextShowIn(_ component: Calendar.Component, value: Int) {
        let date = Calendar.current.date(byAdding: component, value: value, to: Date())
        setNextShowAt(date)
    }
    
    /// Sets the next time to show the item in months.
    /// - Parameter months: Number of months.
    func setNextShowIn(months: Int) {
        setNextShowIn(.month, value: months)
    }
    
    /// Sets the next time to show the item in days.
    /// - Parameter days: Number of days.
    func setNextShowIn(days: Int) {
        setNextShowIn(.day, value: days)
    }
    
    /// Sets the next time to show the item in days.
    /// - Parameter hours: Number of hours.
    func setNextShowIn(hours: Int) {
        setNextShowIn(.hour, value: hours)
    }
    
    /// Sets the next time to show the item in minutes.
    /// - Parameter minutes: Number of minutes.
    func setNextShowIn(minutes: Int) {
        setNextShowIn(.minute, value: minutes)
    }
    
    /// Sets the next time to show the item in seconds.
    /// - Parameter seconds: Number of seconds.
    func setNextShowIn(seconds: Int) {
        setNextShowIn(.second, value: seconds)
    }
    
    /// Sets the item to be shown again in one day.
    func showAgainTomorrow() {
        setNextShowIn(days: 1)
    }
}
