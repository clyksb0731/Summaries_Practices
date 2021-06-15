//
//  ViewController.swift
//  LocalPushTest
//
//  Created by Yongseok Choi on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var startedDateLabel: UILabel!
    @IBOutlet weak var pushLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func setLocalPush() -> Date {
        let content = UNMutableNotificationContent()
        content.title = "테스트 타이틀"
        //content.sound = .default
        content.body = "테스트 바디"
        
        let now = Date()
        let startedDate = Date(timeInterval: 180, since: now)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        print("Now: \(dateFormatter.string(from: now))")
        print("StartedDate: \(dateFormatter.string(from: startedDate))")
        
        let triggerDateCompnent = Calendar.current.dateComponents([.second], from: startedDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateCompnent, repeats: true)
        let request = UNNotificationRequest(identifier: "localPush", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            
        }
        
        return now
    }
    
    @IBAction func stopLocalPush(_ sender: UIButton) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["localPush"])
        
        self.startedDateLabel.text = ""
        self.pushLabel.text = ""
    }
    
    @IBAction func startLocalPush(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        self.startedDateLabel.text = dateFormatter.string(from: self.setLocalPush())
    }
    
    
}

