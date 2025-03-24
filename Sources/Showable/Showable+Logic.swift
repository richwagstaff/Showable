import Foundation

public extension Showable {
    // MARK: Showing
    
    /// Whether the item can be shown.
    /// - Parameter willShowImmediately: Default is `false`. If the item can be shown and this '`willShowImmediately = true`, `didShow` is called by this function.
    /// - Returns: Boolean value.
    func canShow(willShowImmediately: Bool = false) -> Bool {
        guard !isShowingBlocked() else { return false }
        
        setFirstShowRequestedIfNeeded()
        
        guard sufficientTimeElapsed() else { return false }
        
        switch showableType {
        case .schedule:
            break
            
        case .date:
            guard nextShowAtIsInPast() else { return false }
        }
        
        if willShowImmediately {
            didShow()
        }
        
        return true
    }
    
    /// Whether enough time has passed since the last show or first show request.
    /// - Returns: Boolean.
    private func sufficientTimeElapsed() -> Bool {
        guard let lastShownAt = lastShownAt() else {
            let firstShowRequestedAt = firstShowRequestedAt() ?? Date()
            return Date().timeIntervalSince(firstShowRequestedAt) >= minimumTimeSinceFirstShowRequest
        }
        
        return Date().timeIntervalSince(lastShownAt) > minimumTimeBetweenShows
    }
    
    /// Whether the next show at date has been passed.
    /// - Returns: Boolean
    private func nextShowAtIsInPast() -> Bool {
        guard let nextShowAt = nextShowAt() else { return false }
        return Date().timeIntervalSince(nextShowAt) >= 0
    }
    
    /// Call this when the item has been shown to update the last shown at date.
    func didShow() {
        setLastShownAt(Date())
        setNextShowAt(nil)
    }
    
    /// Handles showing the item if it can be shown.
    func showIfNeeded(_ sender: Any?) {
        guard canShow(willShowImmediately: true) else { return }
        show(sender)
    }
    
    // MARK: First Show
    
    /// Sets the first date that the show was requested as now.
    /// - Parameter date: The date.
    func setFirstShowRequested() {
        setFirstShownAt(Date())
    }
    
    /// Sets that the first 'can show' was requested.
    func setFirstShowRequestedIfNeeded() {
        guard firstShowRequestedAt() == nil else { return }
        setFirstShowRequested()
    }
    
    // MARK: Block
    
    /// Call this function to block all future shows from happening.
    func blockShowing() {
        setBlockEnabled(true)
    }
    
    /// Call this function to allow future shows to happen.
    func enableShowing() {
        setBlockEnabled(false)
    }
    
    // MARK: Reset
    
    /// Deletes the dates that the item was first shown at and last shown at.
    func resetShowable() {
        setLastShownAt(nil)
        setFirstShownAt(nil)
        setBlockEnabled(false)
    }
}
