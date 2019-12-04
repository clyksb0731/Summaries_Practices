//
//  ViewController.swift
//  FCM Notification
//
//  Created by 최용석 on 27/11/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = Messaging.messaging().fcmToken {
            print("FCM Token: \(token)")
        }
        
    }


}

