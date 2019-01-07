//
//  ViewController.swift
//  Biometrics
//
//  Created by 최용석 on 01/01/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authTest()
    }
    
    var error: NSError?
    
    func authTest() {
        let auth = LAContext()
//        auth.interactionNotAllowed = false
        print("Before::: ", auth.interactionNotAllowed)
        if auth.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &self.error) {
            auth.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Test Authentication") { (success, error) in
                if success {
                    print("success")
                } else {
                    if let error = error {
                        print(error.localizedDescription)
                        print("failed::::: ", auth.interactionNotAllowed)
                    }
                }
            }
        } else {
            if let error = self.error {
                print(error.localizedDescription)
                print("Can't:::: ", auth.interactionNotAllowed)
            }
        }
    }
}

