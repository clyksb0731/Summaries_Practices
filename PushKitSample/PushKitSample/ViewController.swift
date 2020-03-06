//
//  ViewController.swift
//  PushKitSample
//
//  Created by Yongseok Choi on 2020/03/03.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController {
    
    var callController: CXCallController!
    @IBOutlet weak var tokenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tokenTextField.text = UserDefaults.standard.string(forKey: "deviceToken")
    }
    
}

// MARK: - Objc Methods added
extension ViewController {
    @IBAction func hangUp(_ sender: UIButton) {
        self.callController = CXCallController()
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            delegate.callProvider.reportCall(with: delegate.callUUID, endedAt: Date(), reason: .remoteEnded)
            
//            print("ViewController Call UUID: " + delegate.callUUID.uuidString)
//            let endCall = CXEndCallAction(call: delegate.callUUID)
//            let endTransaction = CXTransaction(action: endCall)
//
//            self.callController.request(endTransaction) { (error) in
//                if let error = error {
//                    print("Error: " + error.localizedDescription)
//                }
//            }
        }
    }
}

//extension ViewController:CXCallObserverDelegate {
//    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
//        <#code#>
//    }
//}
