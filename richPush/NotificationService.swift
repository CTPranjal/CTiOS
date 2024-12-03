//
//  NotificationService.swift
//
//  Created by Pranjal Choudhary on 04/10/23.
//

import UserNotifications
import CleverTapSDK
import CTNotificationService
class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
        CleverTap.sharedInstance()?.recordEvent("Recieved Push");
        super.didReceive(request, withContentHandler: contentHandler)
    }
}

//create one app group(app delegate)(When you need to share data between your app and its app extensions (like widgets, notifications, or watch apps), user default mein jo identity hai, fetch that. take that identity/email and call onUserLogin
