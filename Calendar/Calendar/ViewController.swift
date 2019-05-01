//
//  ViewController.swift
//  Calendar
//
//  Created by 최용석 on 2018. 5. 15..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calendarView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LeftDayCell.self, forCellWithReuseIdentifier: "leftDayCell")
        collectionView.register(RightDayCell.self, forCellWithReuseIdentifier: "rightDayCell")
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "dayCell")
        collectionView.register(CalendarHeaerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.backgroundColor = .white
//        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    var selectedDates: [Date] = []
    
//    var basicDate: [(year: Int, month: Int, days: Int, weekday: Int)] = [(2019, 3, 31, 6), (2019, 4, 30, 2), (2019, 5, 31, 4)]
    var basicDate: [(year: Int, month: Int, days: Int, weekday: Int)] = []
    
    let addingDate: [(year: Int, month: Int, days: Int, weekday: Int)] = [(2019, 2, 28, 6)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setDates()
        self.setDelegates()
        self.setNotifications()
        self.view.addSubview(self.calendarView)
        self.setLayout()
        self.setViewFoundation()
        
        self.testMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Extension for methods added additionally
extension ViewController {
    func testMethod() {
        let date = Date()
        let date2 = Date(timeInterval: -86400, since: date)
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .quarter, .timeZone, .era, .weekday], from: date2)
        
        print("\(dateComponents.month!)월, \(dateComponents.day!)일, \(dateComponents.hour!)시, \(dateComponents.minute!)분", "\(dateComponents.weekday)weekday")
        print("Locale: ", Locale.current.regionCode!)
        
        let dateComponent = DateComponents(calendar: Calendar.current, year: 2009, month: 8, day: 10)
        print("Weekday:::::: ", Calendar.current.dateComponents(in: TimeZone.current, from: dateComponent.date!).weekday)
        
        //        let tmpGDate = DateGenerator(date: Date())
        //        tmpGDate.tmpPrintDateComponent()
        //
        //        let tmpGTDate = DateGenerator(date: Date(timeInterval: -86400 * 180, since: Date()))
        //        tmpGTDate.tmpPrintDateComponent()
        
        print("TimeZone: ", TimeZone.current)
    }
    
    // MARK: Set view foundation
    func setViewFoundation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnotherList(_:)))
        self.navigationItem.title = "Calendar"
    }
    
    // MARK: Set delegate
    func setDelegates() {
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
    }
    
    // MARK: Set layout
    func setLayout() {
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.calendarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    // MARK: Set targets
    func setNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(determinePeriod(_:)), name: NSNotification.Name(rawValue: "determinePeriod"), object: nil)
    }
    
    // MARK: Set dates
    func setDates() {
        self.basicDate = []
        if let currentYearMonth: (year: Int, month: Int) = CoreMethods.shared.getYearMonthOf() {
            var year = currentYearMonth.year
            var month = currentYearMonth.month
            
            for _ in 0..<12 {
                self.basicDate.insert((year: year,
                                       month: month,
                                       days: CoreMethods.shared.getEndDay(year: year, month: month),
                                       weekday: CoreMethods.shared.getWeekday(year: year, month: month, day: 1)!), at: 0)
                
                year = CoreMethods.shared.previousYearMonth(year: year, month: month).year
                month = CoreMethods.shared.previousYearMonth(year: year, month: month).month
            }
        }
    }
}

// MARK: Extension for objc methods added additionally
extension ViewController {
    @objc func determinePeriod(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:Date],
            let date = userInfo["date"] {
            
            if self.selectedDates.count < 2 {
                self.selectedDates.append(date)

            } else {
                self.selectedDates = []
                self.selectedDates.append(date)
            }
            
            self.selectedDates = self.selectedDates.sorted {$0 < $1}
            print("Selected Period::::::::: ", self.selectedDates)
            
            self.calendarView.reloadData()
            
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier:"ko_KR")
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let date2 = formatter.date(from: formatter.string(from: date))
//            let date3 = formatter.string(from: date)
//
//            print("Date::::::::::::::: ", date)
//            print("Date2:::::::::::::: ", date2)
//            print("Date3:::::::::::::: ", date3)
//
//            print(Date())
        }
    }
    
    @objc func addList(_ sender: UIBarButtonItem) {
        self.basicDate = self.addingDate + self.basicDate
        
        self.calendarView.reloadData()
        
        DispatchQueue.main.async {
            self.calendarView.contentOffset.y += (5 * self.calendarView.bounds.width / 8 + 57 + 40)
        }
    }
    
    @objc func addAnotherList(_ sender: UIBarButtonItem) {

    }
        
}

// MARK: Extension for collection view delegate and data source
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.basicDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.basicDate[section].days + self.basicDate[section].weekday - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var item: UICollectionViewCell!
        
        let year = self.basicDate[indexPath.section].year
        let month = self.basicDate[indexPath.section].month
        let weekday = self.basicDate[indexPath.section].weekday
        let day = indexPath.item - (weekday - 2)
        
        if weekday - indexPath.item < 2 {
            if indexPath.item % 7 == 0 {
                let leftItem = collectionView.dequeueReusableCell(withReuseIdentifier: "leftDayCell", for: indexPath) as! LeftDayCell
                
                leftItem.setItem(year: year, month: month, day: day, dates: self.selectedDates)
                
                item = leftItem
                
            } else if indexPath.item % 7 == 6 {
                let rightItem = collectionView.dequeueReusableCell(withReuseIdentifier: "rightDayCell", for: indexPath) as! RightDayCell
                rightItem.setItem(year: year, month: month, day: day, dates: self.selectedDates)
                
                item = rightItem
                
            } else {
                let normalItem = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! DayCell
                normalItem.setItem(year: year, month: month, day: day, dates: self.selectedDates)
                
                item = normalItem
            }
            
        } else {
            if indexPath.item % 7 == 0 {
                let leftItem = collectionView.dequeueReusableCell(withReuseIdentifier: "leftDayCell", for: indexPath) as! LeftDayCell
                leftItem.setItem(year: nil, month: nil, day: nil, dates: nil)
                
                item = leftItem
                
            } else if indexPath.item % 7 == 6 {
                let rightItem = collectionView.dequeueReusableCell(withReuseIdentifier: "rightDayCell", for: indexPath) as! RightDayCell
                rightItem.setItem(year: nil, month: nil, day: nil, dates: nil)
                
                item = rightItem
                
            } else {
                let normalItem = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! DayCell
                normalItem.setItem(year: nil, month: nil, day: nil, dates: nil)
                
                item = normalItem
                
            }
        }
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CalendarHeaerView
        
        headerView.set(year: self.basicDate[indexPath.section].year, month: self.basicDate[indexPath.section].month)
        
        return headerView
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Autolayout width????????????????????????????
        var itemSize: CGSize!
        
        if indexPath.item % 7 == 0  || indexPath.item % 7 == 6 {
            itemSize = CGSize(width: (collectionView.bounds.width) / 16 * 3, height: (collectionView.bounds.width) / 8)
            
        } else {
           itemSize = CGSize(width: (collectionView.bounds.width) / 8, height: (collectionView.bounds.width) / 8)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}
