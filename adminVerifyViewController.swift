//
//  adminVerifyViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/29/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit

class adminVerifyViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        let password = passwordTextField.text
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "admin")
        if (password == "kentAdmin") {
            self.show(vc, sender: nil)
        } else {
            self.errorLabel.text = "Incorrect password. Redirecting"
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                let storyBoard: UIStoryboard = UIStoryboard(name: "profile", bundle: nil)
                let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "profile")
                self.show(vc, sender: nil)
            })
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
