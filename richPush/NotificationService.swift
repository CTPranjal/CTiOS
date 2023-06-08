//
//  NotificationService.swift
//  richPush
//
//  Created by Pranjal Choudhary on 05/06/23.
//


import CTNotificationService
import CleverTapSDK
class NotificationService: CTNotificationServiceExtension {
  var contentHandler: ((UNNotificationContent) -> Void)?
  var bestAttemptContent: UNMutableNotificationContent?
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
      super.didReceive(request, withContentHandler: contentHandler)
  }
}
