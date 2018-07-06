//
//  ViewController.swift
//  Calendar
//
//  Created by 최용석 on 2018. 5. 15..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var date = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .quarter, .timeZone, .era, .weekday], from: date)
        
        print(dateComponents.year)
        print(dateComponents.month)
        print(dateComponents.day)
        print(dateComponents.hour)
        print(dateComponents.minute)
        print(dateComponents.second)
        print(dateComponents.timeZone)
        print(dateComponents.era)
        
        print(Calendar.current.component(.era, from: Date(timeIntervalSince1970: -409968000 - 432000)))
        print(Calendar.current.dateComponents(in: .autoupdatingCurrent, from: Date()))
        
        // Creation of date component directly
        let tmpDateComponents = DateComponents(hour: 5, minute: 2, weekday: 2)
        print(tmpDateComponents)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
