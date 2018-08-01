//
//  ViewController.swift
//  Frizz
//
//  Created by Reem Amer on 7/29/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var frizz: UILabel!
    @IBOutlet weak var gourmetFries: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //Always fill the view
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.contentMode = .scaleToFill
        backgroundImage.addSubview(blurEffectView)
    }
    
    //Two functions below to remove the navigation area
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

