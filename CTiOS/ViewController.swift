//
//  ViewController.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 17/05/23.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController, CleverTapInboxViewControllerDelegate {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var identity_ct: UITextField!
    @IBOutlet weak var email_ct: UITextField!
    @IBOutlet weak var name_ct: UITextField!
    @IBOutlet weak var phone_ct: UITextField!
    @IBOutlet weak var showCtid: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CleverTap.setDebugLevel(3)
        showCtid.isUserInteractionEnabled = true
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyLabelText))
        showCtid.addGestureRecognizer(tapGesture)
//        CleverTap.sharedInstance()?.recordEvent("iPhone Event")
        if let cleverTapID = CleverTap.sharedInstance()?.profileGetID() {
            showCtid.text = cleverTapID
            print("CleverTap ID hello: \(String(describing: cleverTapID))")
        } else {
            showCtid.text = "Unable to retrieve CleverTap ID"
        }
        updateImageForCurrentAppearance()
        initializeAppInbox()
    }
    
    // This method will be called automatically when system appearance changes
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                updateImageForCurrentAppearance()
            }
        }
    // Update image based on current system appearance (light/dark mode)
        func updateImageForCurrentAppearance() {
            if traitCollection.userInterfaceStyle == .dark {
                imageView.image = UIImage(named: "clevertap-1")
            } else {
                imageView.image = UIImage(named: "clevertap-logo")
            }
        }
    
    // Function to copy the label text to clipboard
        @objc func copyLabelText() {
            UIPasteboard.general.string = showCtid.text
            // Optional: Show a confirmation alert
            let alert = UIAlertController(title: "Copied", message: "CTID copied to clipboard", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    func initializeAppInbox() {
            CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
                let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
                let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
                print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
            }))
        }
    
    @IBAction func identitysent(_ sender: Any) {
        // Dismiss the keyboard by resigning the first responder from all text fields
                name_ct.resignFirstResponder()
                identity_ct.resignFirstResponder()
                email_ct.resignFirstResponder()
                phone_ct.resignFirstResponder()
                
                // Create an empty dictionary to hold profile info
        var profile: Dictionary<String, Any> = [:]
                
                // Add each field to the profile if it is not empty
                if let name = name_ct.text, !name.isEmpty {
                    profile["Name"] = name
                }
                
                if let identity = identity_ct.text, !identity.isEmpty {
                    profile["Identity"] = identity
                }
                
                if let email = email_ct.text, !email.isEmpty {
                    profile["Email"] = email
                }
                
                if let phone = phone_ct.text, !phone.isEmpty {
                    profile["Phone"] = phone
                }
                
                // Check if the profile has at least one key-value pair before sending
                if !profile.isEmpty {
                    // Pass the profile data to CleverTap
                    CleverTap.sharedInstance()?.onUserLogin(profile)
                    print("User profile sent to CleverTap: \(profile)")
                }
                else {
                    print("No data to send, all fields are empty")
                }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func ProductView(_ sender: Any) {
        let props = [
            "Product name": "Casio Chronograph Watch",
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ] as [String : Any]

        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
    }
    
    @IBAction func Charged(_ sender: Any) {
        func recordUserChargedEvent() {
                //charged event
                let chargeDetails = [
                    "Amount": 300,
                    "Payment mode": "Credit Card",
                    "Charged ID": 24052013
                    ] as [String : Any]
                
                let item1 = [
                    "Category": "books",
                    "Book name": "The Millionaire next door",
                    "Quantity": 1
                    ] as [String : Any]
                
                let item2 = [
                    "Category": "books",
                    "Book name": "Achieving inner zen",
                    "Quantity": 1
                    ] as [String : Any]
                
                let item3 = [
                    "Category": "books",
                    "Book name": "Chuck it, let's do it",
                    "Quantity": 5
                    ] as [String : Any]
                
                CleverTap.sharedInstance()?.recordChargedEvent(withDetails: chargeDetails, andItems: [item1, item2, item3])
            }
        CleverTap.sharedInstance()?.recordEvent("Charged")
    }
    
    @IBAction func Push(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Recieved Push")
    }
    
    func registerAppInbox() {
               CleverTap.sharedInstance()?.registerInboxUpdatedBlock({
                   let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
                   let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
                   print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
               })
           }
       
    @IBAction func appInbox(_ sender: Any) {
        // config the style of App Inbox Controller
        let style = CleverTapInboxStyleConfig.init()
        style.title = "App Inbox"
        style.backgroundColor = UIColor.systemGray
//        style.messageTags = ["tag1", "tag2"]
        style.navigationBarTintColor = UIColor.systemGray
        style.navigationTintColor = UIColor.blue
        style.tabUnSelectedTextColor = UIColor.blue
        style.tabSelectedTextColor = UIColor.blue
        style.tabSelectedBgColor = UIColor.blue
        style.firstTabTitle = "My First Tab"
            
        if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
            let navigationController = UINavigationController.init(rootViewController: inboxController)
            self.present(navigationController, animated: true, completion: nil)
        }

    }
    
    @IBAction func webOpen(_ sender: Any) {
        // URL to open
//            if let url = URL(string: "https://www.clevertap.com") {
//                // Open the URL in Safari
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                print("Invalid URL")
//            }
//        CleverTap.sharedInstance()?.recordEvent("Opening Website")
        CleverTap.sharedInstance()?.recordEvent("Stories")
    }
}
