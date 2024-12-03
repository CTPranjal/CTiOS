//
//  secondView.swift
//  CTiOS
//
//  Created by Pranjal Choudhary on 02/12/24.
//

import UIKit
import SDWebImage

class secondView: UIViewController {
    
    @IBOutlet weak var ctLogo: SDAnimatedImageView!
    @IBOutlet weak var imageView: UIImageView!

    
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
