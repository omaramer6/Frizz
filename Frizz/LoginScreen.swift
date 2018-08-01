//
//  LoginScreen.swift
//  Frizz
//
//  Created by Reem Amer on 7/30/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    let segueIdentifier = "toMainMenu"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        configureTapGesture()
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.contentMode = .scaleToFill
        backgroundImage.addSubview(blurEffectView)
    }
    
    //When hitting the return key it would work
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName {
            textField.resignFirstResponder()
            userPhoneNumber.becomeFirstResponder()
        } else if textField == userPhoneNumber {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //assigning delegate to the text fields
    private func configureTextFields () {
        userName.delegate = self
        userPhoneNumber.delegate = self
    }
    
    //Tapping will dismiss keyboard
    private func configureTapGesture () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap () {
        view.endEditing(true) //will force keyboard to close
    }
    
    //Login button
    @IBAction func toMenu(_ sender: UIButton) {
        view.endEditing(true) //will force keyboard to close
        
        //Adds alert button
        let alert = UIAlertController(title: "Login Failed", message: "One of the fields is empty", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        //check if one of the fields is empty or not
        if ((userName.text?.isEmpty)! || (userPhoneNumber.text?.isEmpty)!) == true {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == segueIdentifier {
            if let name = userName.text, name.isEmpty {
                return false
            }; if let phone = userPhoneNumber.text, phone.isEmpty {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destination = segue.destination as? MainMenuScreen
            destination?.name = userName.text
            destination?.phone = userPhoneNumber.text
        }
    }
}

