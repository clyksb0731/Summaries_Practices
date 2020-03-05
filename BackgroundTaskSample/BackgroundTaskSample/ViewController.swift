//
//  ViewController.swift
//  BackgroundTaskSample
//
//  Created by Yongseok Choi on 2020/03/05.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var timerOnOff: UILabel!
    var bgTaskID: UIBackgroundTaskIdentifier!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logTextView.layer.borderWidth = 2
        switch self.traitCollection.userInterfaceStyle {
        case .dark:
            self.logTextView.layer.borderColor = UIColor.white.cgColor
            
        case .light:
            self.logTextView.layer.borderColor = UIColor.black.cgColor
            
        case .unspecified:
            self.logTextView.layer.borderColor = UIColor.yellow.cgColor
            
        default:
            self.logTextView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.bgTaskID = UIApplication.shared.beginBackgroundTask {
            if let timer = self.timer, timer.isValid {
                timer.invalidate()
            }
            
            UIApplication.shared.endBackgroundTask(self.bgTaskID)
            self.bgTaskID = .invalid
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timer(_:)), userInfo: nil, repeats: true)
        self.timerOnOff.text = "ON"
    }
}

// MARK: - Objc method added
extension ViewController {
    // Could be the background task at background mode
    @objc func timer(_ timer: Timer) {
        var currentString = self.logTextView.text
        
        switch UIApplication.shared.applicationState {
        case .active:
            let appendedString = "Active: \(UIApplication.shared.backgroundTimeRemaining)\n"
            print(appendedString)
            
            currentString?.append(appendedString)
            
        case .inactive:
            let appendedString = "Inactive: \(UIApplication.shared.backgroundTimeRemaining)\n"
            print(appendedString)
            
            currentString?.append(appendedString)
            
        case .background:
            let appendedString = "Background: \(UIApplication.shared.backgroundTimeRemaining)\n"
            print(appendedString)
            
            currentString?.append(appendedString)
            
        @unknown default:
            fatalError()
        }
        
        self.logTextView.text = currentString
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        if let bgTaskID = self.bgTaskID, bgTaskID != .invalid {
            DispatchQueue.global().async {
                UIApplication.shared.endBackgroundTask(self.bgTaskID)
                self.bgTaskID = .invalid
            }
        }
        
        if let timer = self.timer, timer.isValid {
            self.timerOnOff.text = "ON"
            
        } else {
            self.timerOnOff.text = "OFF"
        }
    }
    
    @objc func didEnterBackground(_ notification: Notification) {
        if self.bgTaskID == .invalid {
            self.bgTaskID = UIApplication.shared.beginBackgroundTask {
                if self.timer.isValid {
                    self.timer.invalidate()
                }
                
                UIApplication.shared.endBackgroundTask(self.bgTaskID)
                self.bgTaskID = .invalid
            }
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        self.logTextView.text = ""
        
        if !self.timer.isValid {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timer(_:)), userInfo: nil, repeats: true)
            self.timerOnOff.text = "ON"
        }
        
        if self.bgTaskID == .invalid {
            self.bgTaskID = UIApplication.shared.beginBackgroundTask {
                if self.timer.isValid {
                    self.timer.invalidate()
                }
                
                UIApplication.shared.endBackgroundTask(self.bgTaskID)
                self.bgTaskID = .invalid
            }
        }
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        if self.timer.isValid {
            self.timer.invalidate()
            self.timerOnOff.text = "OFF"
        }
        
        if self.bgTaskID != .invalid {
            DispatchQueue.global().async {
                UIApplication.shared.endBackgroundTask(self.bgTaskID)
                self.bgTaskID = .invalid
            }
        }
    }
}
