//
//  ViewController.swift
//  PushKitSample
//
//  Created by Yongseok Choi on 2020/03/03.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import CallKit
import AVFoundation

class ViewController: UIViewController {
    
    var callController: CXCallController!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var checkingView: UIView!
    @IBOutlet weak var viewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkingView.backgroundColor = .cyan
        
        NotificationCenter.default.addObserver(self, selector: #selector(speakerChanged(_:)), name: AVAudioSession.routeChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewColor(_:)), name: Notification.Name("changeViewColor"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewLabel(_:)), name: Notification.Name("changeViewLabel"), object: nil)
        
        self.callController = CXCallController()
        print("CallController:::::::::;")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tokenTextField.text = UserDefaults.standard.string(forKey: "deviceToken")
        
        self.callController.callObserver.setDelegate(self, queue: nil)
    }
    
}

// MARK: - Objc Methods added
extension ViewController {
    @IBAction func hangUp(_ sender: UIButton) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            //delegate.callProvider.reportCall(with: delegate.callUUID, endedAt: Date(), reason: .remoteEnded)
            
            print("ViewController Call UUID: " + delegate.callUUID.uuidString)
            let endCall = CXEndCallAction(call: delegate.callUUID)
            let endTransaction = CXTransaction(action: endCall)
            
            self.callController.request(endTransaction) { (error) in
                if let error = error {
                    print("Error: " + error.localizedDescription)
                    
                } else {
                    print("Succeeded in ending call")
                }
            }
        }
    }
    
    @objc func speakerChanged(_ notification: Notification) {
        print("Notification for speaker")
    }
    
    @objc func changeViewColor(_ notification: Notification) {
        if let userInfo = notification.userInfo, let color = userInfo["color"] as? String {
            if color == "before" {
                self.checkingView.backgroundColor = .green
                self.viewLabel.textColor = .white
                
            } else if color == "after" {
                self.checkingView.backgroundColor = .yellow
                self.viewLabel.textColor = .black
                
            } else {
                self.checkingView.backgroundColor = .blue
                self.viewLabel.textColor = .white
            }
        }
    }
    
    @objc func changeViewLabel(_ notification: Notification) {
        if let userInfo = notification.userInfo, let number = userInfo["number"] as? String {
            self.viewLabel.text = number;
        }
    }
}

extension ViewController:CXCallObserverDelegate {
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        print("Call Changed")
    }
}
