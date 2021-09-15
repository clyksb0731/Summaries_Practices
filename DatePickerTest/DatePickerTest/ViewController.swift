//
//  ViewController.swift
//  DatePickerTest
//
//  Created by Yongseok Choi on 2021/07/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yearAndMonthDatePicker: UIDatePicker!
    @IBOutlet weak var timeDatePIcker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func yearAndMonthDatePicker(_ sender: UIDatePicker) {
        var calendar = Calendar.current
        calendar.locale = .current
        calendar.timeZone = .current
        
        let dateComponent = calendar.dateComponents([.year, .month, .day], from: sender.date)
        print("Year:\(dateComponent.year ?? 0) Month:\(dateComponent.month ?? 0) Day:\(dateComponent.day ?? 0)")
    }
    

    @IBAction func timeDatePicker(_ sender: UIDatePicker) {
        var calendar = Calendar.current
        calendar.locale = .current
        calendar.timeZone = .current
        
        let dateComponent = calendar.dateComponents([.hour, .minute], from: sender.date)
        print("Hour:\(dateComponent.hour ?? 0) Minute:\(dateComponent.minute ?? 0)")
    }
}

