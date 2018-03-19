//
//  verifyViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/5/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        Auth.auth().signIn(with: credential) { (user: User?,error ) in
            if let error = error {
                
            }
            var ref: DatabaseReference
            ref = Database.database().reference()
            print("The user is signed in and authenticated")
            let uid = user?.uid
            let phone = UserDefaults.standard.string(forKey: "phoneNumber")
            ref.child("users").child(uid!).setValue(["username": phone])
            let sb: UIStoryboard = UIStoryboard(name: "profile", bundle: nil)
            let vc: UIViewController = sb.instantiateInitialViewController()!
            self.present(vc, animated: true, completion: {
                
            })
            self.storeQRCode(phone: phone!)
        }
        
        
        
       
    }
    func storeQRCode(phone: String) {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("url")
        let textMessage = "Thank you for scanning into the event!"
        let urlTextMessage = textMessage.replacingOccurrences(of: " ", with: "%20")
        let sms = ("SMSTO:\(phone):\(urlTextMessage)")
        
        let phoneURL = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(sms)")
        userRef.setValue(["smsURL": phoneURL])
    }
    
}
