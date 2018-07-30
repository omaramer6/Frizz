//
//  LoginScreen.swift
//  Frizz
//
//  Created by Reem Amer on 7/30/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.contentMode = .scaleToFill
        backgroundImage.addSubview(blurEffectView)
    }

    @IBAction func toMenu(_ sender: UIButton) {
    }
}
