//
//  LoginScreen.swift
//  Frizz
//
//  Created by Reem Amer on 7/30/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginScreen: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    let segueIdentifier = "toMainMenu"
    static var results: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        configureTapGesture()
        
        let loginButtonFB = FBSDKLoginButton()
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.contentMode = .scaleToFill
        
        loginButtonFB.frame = CGRect(x: 64, y: 520, width: view.frame.width - 128, height: 40)
        loginButtonFB.delegate = self
        
        backgroundImage.addSubview(blurEffectView)
        view.addSubview(loginButtonFB)
    }
    
    //function for FB login button delegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        } else {
            if (result.grantedPermissions != nil) {
                returnUserData()
                self.performSegue(withIdentifier: segueIdentifier, sender: self)
            } else {
                return
            }
        }
    }
    
    //getting user data when logging in
    func returnUserData() {
        let accessToken = FBSDKAccessToken.current()
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"], tokenString: accessToken?.tokenString  , version: nil, httpMethod: "GET")
        _ = request?.start(completionHandler: { (connection, result, error) in
            if error == nil {
                print(result!)
                LoginScreen.results = result
            } else {
                print(error!)
            }
        })
    }
    
    //function for FB login button delegate
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of Facebook")
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
    //Checks whether name is all letters or not
    private func containsOnlyLetters(input: String) -> Bool {
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    //Check whether phone number is all numbers
    private func containsOnlyNumbers (input: String) -> Bool {
        for chr in input {
            if !(chr >= "0" && chr <= "9") {
                return false
            }
        }
        return true
    }

@objc func handleTap () {
    view.endEditing(true) //will force keyboard to close
}

//Login button
@IBAction func toMenu(_ sender: UIButton) {
    view.endEditing(true) //will force keyboard to close
    
    //Adds alert button
    let emptyFieldAlert = UIAlertController(title: "Login Failed", message: "One of the fields is empty", preferredStyle: UIAlertControllerStyle.alert)
    emptyFieldAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    //Adds alert button
    let wrongPhoneNumberAlert = UIAlertController(title: "Login Failed", message: "Wrong Phone Number", preferredStyle: UIAlertControllerStyle.alert)
    wrongPhoneNumberAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    //Adds alert button
    let invalidNameAlert = UIAlertController(title: "Login Failed", message: "Wrong Name", preferredStyle: UIAlertControllerStyle.alert)
    invalidNameAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    
    //check if one of the fields is empty or not
    if ((userName.text?.isEmpty)! || (userPhoneNumber.text?.isEmpty)!) == true {
        self.present(emptyFieldAlert, animated: true, completion: nil)
    }; if userPhoneNumber.text?.count != 11 || !containsOnlyNumbers(input: userPhoneNumber.text!) {
        self.present(wrongPhoneNumberAlert, animated: true, completion: nil)
    }; if !containsOnlyLetters(input: userName.text!) {
        self.present(invalidNameAlert, animated: true, completion: nil)
    }
}

override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if identifier == segueIdentifier {
        if let name = userName.text, let phone = userPhoneNumber.text, name.isEmpty || phone.isEmpty {
            return false
        }
        if let phoneDigits = userPhoneNumber.text, phoneDigits.count != 11 || !containsOnlyNumbers(input: userPhoneNumber.text!) {
            return false
        }
        if let _ = userName.text, !containsOnlyLetters(input: userName.text!) {
            return false
        }
    }
    return true
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == segueIdentifier {
        let destination = segue.destination as? OfficialMenu
        destination?.name = userName.text
        destination?.phone = userPhoneNumber.text
    }
}
}

