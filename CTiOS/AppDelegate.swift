//
//  AppDelegate.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 17/05/23.
//

import UIKit
import CleverTapSDK
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,CleverTapURLDelegate {
    func shouldHandleCleverTap(_ url: URL?, for channel: CleverTapChannel) -> Bool {
        print("Handling URL: ----\(url!) for channel: \(channel)")
       
        return true
    }
        
//    
//    func shouldHandleCleverTap(_ url: URL?, for channel: CleverTapChannel) -> Bool {
//       
//    }
////    
//    func showAlert() {
//           let alert = UIAlertController(title: "Logout?", message: "Are you sure you want to logout? You can login back to access your content.", preferredStyle: .alert)
//             
//           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
//               //Cancel Action
//           }))
//           alert.addAction(UIAlertAction(title: "Logout",
//                                         style: UIAlertAction.Style.default,
//                                         handler: {(_: UIAlertAction!) in
//                                           //Sign out action
//           }))
//            
//
//       }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.autoIntegrate()
        CleverTap.sharedInstance()?.setUrlDelegate(self)
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        registerForPush()
        return true
    }
    
    func registerForPush() {
        // Register for Push notifications
        UNUserNotificationCenter.current().delegate = self
        
        
        
        // request Permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
        
        
//         MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
         // CleverTapURLDelegate method
      
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            
            NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
            completionHandler()
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
            completionHandler([.badge, .sound, .alert])
        }
        
        func application(_ application: UIApplication,
                         didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
            completionHandler(UIBackgroundFetchResult.noData)
        }
        
        func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
            NSLog("pushNotificationTapped: customExtras: ", customExtras)
        }       
    
}
