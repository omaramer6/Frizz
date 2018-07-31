//
//  MainMenuScreen.swift
//  Frizz
//
//  Created by Reem Amer on 7/31/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class MainMenuScreen: UIViewController {

    var name: String?
    var phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
