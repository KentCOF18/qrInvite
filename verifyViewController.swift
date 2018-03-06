//
//  verifyViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/5/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth

class verifyViewController: UIViewController {

    @IBAction func verifyButton_TouchUpInside(_ sender: Any) {
        let code = codeTextField.text
        verifyCode(code: code!)
    }
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    func verifyCode (code: String) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: code)
        Auth.auth().signIn(with: credential) { (user,error ) in
            if let error = error {
                
            }
            print("The user is signed in and authenticated")
        }
    }

}
