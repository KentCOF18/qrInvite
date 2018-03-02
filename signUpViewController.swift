//
//  signUpViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/2/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {

    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBAction func signUpButton_TouchUpInside(_ sender: Any) {
        sendVerificationCode()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    func sendVerificationCode() {
        let phoneNumber = "+1" + (phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error ) in
            if let error = error {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                print("Phone number error" + error.localizedDescription)
            }
        }
    }


}


