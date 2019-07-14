//
//  ViewController.swift
//  RxSwift_Sample
//
//  Created by Yongseok Choi on 11/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var asyncCheckLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(postAsyncCheck(_:)), name: Notification.Name(rawValue: "asyncCheck"), object: nil)
        
    }
    
    @IBAction func checkAsyncButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "asyncCheck"), object: nil)
        self.asyncCheckLabel.text = "Check Button touched"
    }
    
    @objc func postAsyncCheck(_ notification: Notification) {
        for _ in 1...100_000_000 {
            
        }
        
        self.notificationLabel.text = "After Notification"
    }
}

