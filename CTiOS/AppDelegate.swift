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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.autoIntegrate()
        CleverTap.sharedInstance()?.setUrlDelegate(self)
        CleverTap.setDebugLevel(3)
        registerForPush()
        
        //        if let remoteNotification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
        //                CleverTap.sharedInstance()?.handleNotification(withData: remoteNotification)
        //                handleCleverTapNotification(userInfo: remoteNotification)
        //            }
        return true
        
        //CleverTap.sharedInstance()?.notifyApplicationLaunched(withOptions: nil)
        //CleverTap.sharedInstance()?.applicationDidLaunch(options: launchOptions)
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
        
        //            CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo)
        //                handleCleverTapNotification(userInfo: response.notification.request.content.userInfo)
        //                completionHandler(.newData)
        
        completionHandler()
    }
    
    //    func handleCleverTapNotification(userInfo: [AnyHashable: Any]) {
    //        // Extract CleverTap's deep link key (wzrk_dl)
    //        if let deepLink = userInfo["wzrk_dl"] as? String, let url = URL(string: deepLink) {
    //            handleDeepLink(url: url)
    //        } else {
    //            print("No deep link found in CleverTap notification.")
    //        }
    //    }
    //
    //    func handleDeepLink(url: URL) {
    //        guard let scheme = url.scheme, scheme == "myapp" else {
    //            print("Invalid deep link scheme.")
    //            return
    //        }
    //
    //        let host = url.host
    //        let pathComponents = url.pathComponents
    //
    //        if host == "feature1" {
    //            navigateToFeature1()
    //        } else if host == "feature2" {
    //            navigateToFeature2(with: pathComponents)
    //        } else {
    //            print("Unknown deep link host.")
    //        }
    //    }
    //
    //    func navigateToFeature1() {
    //        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
    //            let featureVC = Feature1ViewController()
    //            rootVC.present(featureVC, animated: true)
    //        }
    //    }
    //
    //    func navigateToFeature2(with pathComponents: [String]) {
    //        // Navigate based on deeper paths if needed
    //    }
    
    
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
    
    public func shouldHandleCleverTap(_ url: URL?, for channel: CleverTapChannel) -> Bool {
        print("Handling URL: \(url!) for channel: \(channel)")
        
        // Check if the URL is valid and starts with "https://"
        if let urlString = url?.absoluteString, urlString.contains("https://") {
            print("Handling https:// URL: \(urlString)")
            
            // Parse the URL components to check the path
            if let urlComponents = URLComponents(string: urlString),
               let path = urlComponents.path.split(separator: "/").last {
                
                if path == "secondView" {
                    // Navigate to SecondView
                    print("Navigating to SecondView")
                    
                    // Assuming this function is inside a UIViewController
                    if let currentViewController = UIApplication.shared.keyWindow?.rootViewController {
                        // Create an instance of the storyboard
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        // Instantiate the secondView
                        if let secondView = storyboard.instantiateViewController(withIdentifier: "secondViewId") as? secondView {
                            
                            // Present or push the view controller
                            if let navigationController = currentViewController as? UINavigationController {
                                navigationController.pushViewController(secondView, animated: true)
                            } else {
                                currentViewController.present(secondView, animated: true, completion: nil)
                            }
                        }
                    }
                    return false
                } else {
                    // Open other "https://" links in a browser
                    print("Opening URL in browser: \(urlString)")
                    if let urlToOpen = URL(string: urlString) {
                        UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
                    }
                    return false
                }
            }
        } else {
            print("URL not recognized or doesn't start with https://")
            return false
        }
        return false
    }

    
}
