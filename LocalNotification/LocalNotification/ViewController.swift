//
//  ViewController.swift
//  LocalNotification
//
//  Created by 최용석 on 2018. 11. 1..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var setDate: UIDatePicker!
    @IBOutlet weak var notiSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var date = Date(timeIntervalSinceNow: 60)
////        date += Date(timeIntervalSinceNow: 1000)
//        var tmpDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, ], from: date)
//        print(date)
//        print(tmpDate.year)
        
        self.setDate.datePickerMode = .dateAndTime
        self.setDate.locale = Locale(identifier: "ko_Ko")
        
        
        
    }
    
    @IBAction func actionDatePicker(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        
    }
    
    @IBAction func actionButtion(_ sender: UIButton) {
        print("Calendar", self.setDate.calendar)
        print("Date: ", self.setDate.date)
        
        let tmpDate = DateFormatter()
        tmpDate.calendar = self.setDate.calendar
        print("DateFormatter: ", tmpDate)
        
        let trigger = Calendar.current.dateComponents([.month, .year, .day, .hour, .minute, .second, .nanosecond], from: self.setDate.date)
        print("Components: ", trigger)
        
        let tmpDateComponents = DateComponents(hour: 18, minute: 2, weekday: 2)
        print("madeComponents: ", tmpDateComponents)
    }
    
    func createNotiCategory() -> UNNotificationCategory {
        let firstAction: UNNotificationAction = UNNotificationAction(identifier: "first", title: "First Action", options: [])
        
        let secondAction: UNNotificationAction = UNNotificationAction(identifier: "second", title: "Second Action", options: [.destructive])
        
        let newCategory: UNNotificationCategory = UNNotificationCategory(identifier: "newCategory", actions: [firstAction, secondAction], intentIdentifiers: [], options: [])
        
        return newCategory
    }
    
}

