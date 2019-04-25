//
//  ViewController.swift
//  NotificationCenterSample
//
//  Created by 최용석 on 26/04/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

enum TempType {
    case up
    case down
}

class ViewController: UIViewController {
    
    @IBOutlet weak var receivedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNotification()
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(expressData(_:)), name: Notification.Name("receivedData"), object: nil)
    }
    
    @objc func expressData(_ notification: Notification) {
        if let data = notification.userInfo as? [String:TempType] {
            if let type = data["data"] {
                switch type {
                case .up:
                    self.receivedLabel.text = "Up"
                    
                case .down:
                    self.receivedLabel.text = "Down"
                }
            }
        }
    }
}

