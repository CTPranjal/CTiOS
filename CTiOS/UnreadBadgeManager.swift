//
//  UnreadBadgeManager.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 20/02/25.
//

import Foundation
import UserNotifications

class UnreadBadgeManager {
    static let shared = UnreadBadgeManager()
    private let badgeKey = "unreadBadgeCount"
    private let appGroup = "group.com.biswa.Test" // <-- Replace with your App Group ID
    private init() {}
    // Get the current badge count from UserDefaults
    func getBadgeCount() -> Int {
        let defaults = UserDefaults(suiteName: appGroup)
        return defaults?.integer(forKey: badgeKey) ?? 0
    }
    // Set the badge count in UserDefaults & update badge number
    func setBadgeCount(_ count: Int) {
        let newCount = max(0, count) // Prevent negative values
        let defaults = UserDefaults(suiteName: appGroup)
        defaults?.set(newCount, forKey: badgeKey)
        defaults?.synchronize() // Ensure it's saved
        if #available(iOS 17.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(newCount) { error in
                if let error = error {
                    print("Failed to set badge count: \(error.localizedDescription)")
                }
            }
        }
//        else {
//            UIApplication.shared.applicationIconBadgeNumber = newCount
//        }
    }
    // Increment badge count when receiving a new notification
    func incrementBadgeCount() {
        setBadgeCount(getBadgeCount() + 1)
    }
    // Decrement badge count when a notification is clicked
    func decrementBadgeCount() {
        setBadgeCount(getBadgeCount() - 1)
//        NSLog("%@: badge count: %@", getBadgeCount())
    }
}
