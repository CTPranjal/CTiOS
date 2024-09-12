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
    @IBOutlet weak var showCtid: UILabel!

    @IBOutlet weak var identiy_ct: UITextField!
    @IBOutlet weak var email_ct: UITextField!
    @IBOutlet weak var name_ct: UITextField!
    @IBOutlet weak var phone_ct: UITextField!
    //    @IBOutlet weak var get_identity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CleverTap.sharedInstance()?.recordEvent("iPhone Event")
        if let cleverTapID = CleverTap.sharedInstance()?.profileGetID() {
            showCtid.text = cleverTapID
            print("CleverTap ID hello: \(String(describing: cleverTapID))")
        } else {
            showCtid.text = "Unable to retrieve CleverTap ID"
        }
        initializeAppInbox()
    }
    
    func initializeAppInbox() {
            CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
                let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
                let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
                print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
            }))
        }
    
    @IBAction func identitysent(_ sender: Any) {
        if let ctname = name_ct.text {
           let name = ctname
           print("Name is: \(name)")
        }
        if let ctidentity = identiy_ct.text {
           let identity = ctidentity
           print("Identity is: \(identity)")
        }
        if let ctemail = email_ct.text {
           let email = ctemail
           print("Email is: \(email)")
        }
        if let ctphone = phone_ct.text {
           let phone = ctphone
           print("Phone is: \(phone)")
        }
    }
    
    
    @IBAction func Login(_ sender: Any) {
        let profile: Dictionary<String,Any> = [
                
                  "Email" : "pranjalpc@clevertap.com",
                  "Phone" : "+917020384173"
        ]
        CleverTap.sharedInstance()?.onUserLogin(profile)
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
        CleverTap.sharedInstance()?.recordEvent("t3")
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
    
    @IBAction func nps(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("try77")
    }
}

