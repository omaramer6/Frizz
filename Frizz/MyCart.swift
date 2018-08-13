//
//  MyCart.swift
//  Frizz
//
//  Created by Reem Amer on 8/12/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class MyCart: UIViewController {
    
    @IBOutlet weak var dismissCartButton: UIButton!
    @IBAction func dismissCart(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
