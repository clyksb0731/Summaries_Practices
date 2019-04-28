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
        let calendarView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        calendarView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.calendarView)
        self.setLayout()
        self.setDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print("Tmp Date:::::: ", dateComponent.date!)
        
        //        let tmpGDate = DateGenerator(date: Date())
        //        tmpGDate.tmpPrintDateComponent()
        //
        //        let tmpGTDate = DateGenerator(date: Date(timeInterval: -86400 * 180, since: Date()))
        //        tmpGTDate.tmpPrintDateComponent()
        
        print("TimeZone: ", TimeZone.current)
    }
}

// MARK: Extension for collection view delegate and data source
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel(frame: cell.contentView.frame)
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = String(indexPath.row)
        cell.contentView.addSubview(label) // FIXME: Continuously adding.
        cell.contentView.backgroundColor = .yellow
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 1
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width) / 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
