//
//  ViewController.swift
//  DatePicker
//
//  Created by 최용석 on 2018. 6. 20..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker = self.createDatePicker()
        self.datePicker?.addTarget(self, action: #selector(printDate(_:)), for: .valueChanged)
        self.view.addSubview(datePicker!)
        self.setLayoutOfDatePicker(view: self.datePicker!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_Ko")
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }
    
    func setLayoutOfDatePicker(view: UIView) {
        guard let datePicker = view as? UIDatePicker else { return }
        let safeGuide = self.view.safeAreaLayoutGuide
        
        safeGuide.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: -100).isActive = true
        safeGuide.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -30).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: 30).isActive = true
        safeGuide.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 100).isActive = true
    }
    
    @objc func printDate(_ sender: UIDatePicker) {
        print("Date added timeinterval")
        print(sender.date.addingTimeInterval(9*3600))
        print("DateComponents selected")
        print(Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: sender.date))
        print("Calendar.Component selected")
        print(Calendar.current.component(.weekday, from: sender.date))
        print("Calendar::")
        print(Calendar.current)
        // creation of date component object
        let tmpDateComponents = DateComponents(hour: 5, minute: 2, weekday: 2)
        print(tmpDateComponents)
    }
}
