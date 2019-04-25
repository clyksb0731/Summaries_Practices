//
//  NextViewController.swift
//  NotificationCenterSample
//
//  Created by 최용석 on 26/04/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var dataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToPreviousVC(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func transferDataToNotificationCenter(_ sender: UIButton) {
        var userInfo:[String:TempType] = [:]
        if self.dataTextField.text == "Up" {
            userInfo.updateValue(.up, forKey: "data")
            
        } else {
            userInfo.updateValue(.down, forKey: "data")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("receivedData"), object: nil, userInfo: userInfo)
    }
}
