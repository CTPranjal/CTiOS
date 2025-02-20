//
//  secondView.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 02/12/24.
//

import UIKit
import SDWebImage
import CleverTapSDK

class secondView: UIViewController {
    @IBOutlet weak var ctLogo: SDAnimatedImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timer: UIButton!
    @IBOutlet weak var quiz: UIButton!
    @IBOutlet weak var stories: UIButton!
    @IBOutlet weak var feedback: UIButton!
    @IBOutlet weak var PIP: UIButton!
    @IBOutlet weak var spinWheel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageForCurrentAppearance()
        
        // Do any additional setup after loading the view.
    }
    // This method will be called automatically when system appearance changes
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                updateImageForCurrentAppearance()
            }
        }
    
    @IBAction func timer(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Timer In-App")
    }
    @IBAction func quiz(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Start Quiz")
    }
    @IBAction func stories(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Stories")
    }
    @IBAction func feedback(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Initiate Feedback")
    }
    @IBAction func PIP(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("PIP")
    }
    @IBAction func spinWheel (_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Spin It")
    }
    // Update image based on current system appearance (light/dark mode)
        func updateImageForCurrentAppearance() {
            if traitCollection.userInterfaceStyle == .dark {
                imageView.image = UIImage(named: "clevertap-1")
            } else {
                imageView.image = UIImage(named: "clevertap-logo")
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
