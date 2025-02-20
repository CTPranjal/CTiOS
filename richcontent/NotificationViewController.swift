//
//  NotificationViewController.swift
//  richcontent
//
//  Created by Pranjal Choudhary on 28/08/24.

import UIKit
import UserNotifications
import UserNotificationsUI
import CTNotificationContent

class NotificationViewController: CTNotificationViewController {

    @IBOutlet var label: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // register category with actions
                let action1 = UNNotificationAction(identifier: "action_4", title: "Back", options: [])
                let action2 = UNNotificationAction(identifier: "action_5", title: "Next", options: [])
                let action3 = UNNotificationAction(identifier: "action_6", title: "View In App", options: [])
                let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
                let category2 = UNNotificationCategory(identifier: "ctTimer", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category])
        // Do any required interface initialization here.
    }

    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body

    }

    override func userDidPerformAction(_ action: String, withProperties properties: [AnyHashable : Any]!) {
        print("userDidPerformAction \(action) with props \(String(describing: properties))")
    }

    // optional: implement to get notification response
    override func userDidReceive(_ response: UNNotificationResponse?) {
        print("Push Notification Payload \(String(describing: response?.notification.request.content.userInfo))")
        let notificationPayload = response?.notification.request.content.userInfo
        if (response?.actionIdentifier == "action_2") {
            let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
        }
    }

}
