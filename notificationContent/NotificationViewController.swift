//
//  NotificationViewController.swift
//  notificationContent
//
//  Created by Pranjal Choudhary on 06/06/23.
//
//import UIKit
import CleverTapSDK
import CTNotificationContent

class NotificationViewController: CTNotificationViewController {

    @IBOutlet var label: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
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
            CleverTap.sharedInstance()?.recordNotificationClickedEvent(withData: notificationPayload ?? "")
        }
    }

}
//
//
//import UIKit
//import UserNotifications
//import UserNotificationsUI
//import CleverTapSDK
//import CTNotificationContent
//
//
//class NotificationViewController: CTNotificationViewController {
//    class NotificationViewController: CTNotificationViewController {
//    
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        }
//    
//        // optional: implement to get user event data
//        override func userDidPerformAction(_ action: String, withProperties properties: [AnyHashable : Any]!) {
//            print("userDidPerformAction \(action) with props \(String(describing: properties))")
//        }
//    
//        // optional: implement to get notification response
//        override func userDidReceive(_ response: UNNotificationResponse?) {
//            print("Push Notification Payload \(String(describing: response?.notification.request.content.userInfo))")
////            let notificationPayload = response?.notification.request.content.userInfo
////            if (response?.actionIdentifier == "action_2") {
////                CleverTap.sharedInstance()?.recordNotificationClickedEvent(withData: notificationPayload ?? "")
//            
//            let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
//              let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
//              let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
//              let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
//              UNUserNotificationCenter.current().setNotificationCategories([category])
//            }
//        }
//    }
//
