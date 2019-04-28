//
//  ViewController.swift
//  Calendar
//
//  Created by 최용석 on 2018. 5. 15..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var calendarView: UICollectionView = {
//        let calendarView = UICollectionView()
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//
//        return calendarView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setDelegates()
        
        let date = Date()
        let date2 = Date(timeInterval: -86400, since: date)
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .quarter, .timeZone, .era, .weekday], from: date2)
        
        print("\(dateComponents.month!)월, \(dateComponents.day!)일, \(dateComponents.hour!)시, \(dateComponents.minute!)분", "\(dateComponents.weekday)weekday")
        print("Locale: ", Locale.current.regionCode!)
        
        let dateComponent = DateComponents(calendar: Calendar.current, year: 2009, month: 8, day: 10)
        print("Tmp Date:::::: ", dateComponent.date!)
        
//        let tmpGDate = DateGenerator(date: Date())
//        tmpGDate.tmpPrintDateComponent()
//
//        let tmpGTDate = DateGenerator(date: Date(timeInterval: -86400 * 180, since: Date()))
//        tmpGTDate.tmpPrintDateComponent()
        
        print("TimeZone: ", TimeZone.current)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Set delegate
    func setDelegates() {
//        self.calendarView.delegate = self
//        self.calendarView.dataSource = self
    }
}

// MARK: Extension for collection view delegate and data source
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//
//
//}
