//
//  ViewController.swift
//  LocalNotification
//
//  Created by 최용석 on 2018. 6. 3..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var date = Date(timeIntervalSinceNow: 60)
//        date += Date(timeIntervalSinceNow: 1000)
        var tmpDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, ], from: date)
        print(date)
        print(tmpDate.year)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

