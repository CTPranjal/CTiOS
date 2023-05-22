//
//  ViewController.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 17/05/23.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CleverTap.sharedInstance()?.recordEvent("iPhone Event")

    }
    
    @IBAction func Login(_ sender: Any) {
//        let dob = NSDateComponents()
//        dob.day = 07
//        dob.month = 07
//        dob.year = 2000
//        let d = NSCalendar.currentCalendar.dateFromComponents(dob)
        let profile: Dictionary<String,Any> = [
            "Name": "CT Pranjal 🍣",
            "Identity": "7",
            "Email": "pranjal@clevertap.com",
            "Phone": "7737051770",
//            "DOB": d! as AnyObject,
            "Gender": "F",
            "Photo": "https://avatars.githubusercontent.com/u/66253465?v=4" as AnyObject,
            //Update custom profile properties
            "MSG-push": true,
            "Plan type": "Diamond",
            "Favorite Food": "Sushi 🍣"
            
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
        print("push pressed")
    }
    
    @IBAction func Push(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Push iOS")
        print("push pressed")
    }
    
}

