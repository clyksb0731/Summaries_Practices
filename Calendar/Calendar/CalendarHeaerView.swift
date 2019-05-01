//
//  CalendarHeaerView.swift
//  Calendar
//
//  Created by 최용석 on 01/05/2019.
//  Copyright © 2019 clyksb0731. All rights reserved.
//

import UIKit

class CalendarHeaerView: UICollectionReusableView {
    var yearMonthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor.getRGB(0, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var sundayLabel: UILabel!
    var mondayLabel: UILabel!
    var tuesdayLabel: UILabel!
    var wednesdayLabel: UILabel!
    var thursdayLabel: UILabel!
    var fridayLabel: UILabel!
    var saturdayLabel: UILabel!
    
    var sundayView: UIView!
    var mondayView: UIView!
    var tuesdayView: UIView!
    var wednesdayView: UIView!
    var thursdayView: UIView!
    var fridayView: UIView!
    var saturdayView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setWeekday()
        self.setSubviews()
        self.setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        CoreMethods.shared.addSubviews([
            self.sundayView,
            self.mondayView,
            self.tuesdayView,
            self.wednesdayView,
            self.thursdayView,
            self.fridayView,
            self.saturdayView], to: self)
        
        CoreMethods.shared.addSubviews([
            self.yearMonthLabel,
            self.sundayLabel,
            self.mondayLabel,
            self.tuesdayLabel,
            self.wednesdayLabel,
            self.thursdayLabel,
            self.fridayLabel,
            self.saturdayLabel], to: self)
    }
    
    func setWeekday() {
        self.sundayLabel = getWeekdayLabel("일")
        self.mondayLabel = getWeekdayLabel("월")
        self.tuesdayLabel = getWeekdayLabel("화")
        self.wednesdayLabel = getWeekdayLabel("수")
        self.thursdayLabel = getWeekdayLabel("목")
        self.fridayLabel = getWeekdayLabel("금")
        self.saturdayLabel = getWeekdayLabel("토")
        
        self.sundayView = getWeekdayView()
        self.mondayView = getWeekdayView()
        self.tuesdayView = getWeekdayView()
        self.wednesdayView = getWeekdayView()
        self.thursdayView = getWeekdayView()
        self.fridayView = getWeekdayView()
        self.saturdayView = getWeekdayView()
    }
    
    func getWeekdayLabel(_ weekday: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.getRGB(128, 128, 128)
        label.text = weekday
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }
    
    func getWeekdayView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    func set(year: Int, month: Int) {
        self.yearMonthLabel.text = "\(year)년 \(month)월"
        self.yearMonthLabel.sizeToFit()
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.yearMonthLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.yearMonthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.sundayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.sundayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.sundayView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.width / 16),
            self.sundayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.sundayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.sundayLabel.centerXAnchor.constraint(equalTo: self.sundayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.mondayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mondayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.mondayView.leadingAnchor.constraint(equalTo: self.sundayView.trailingAnchor),
            self.mondayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.mondayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mondayLabel.centerXAnchor.constraint(equalTo: self.mondayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.tuesdayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tuesdayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.tuesdayView.leadingAnchor.constraint(equalTo: self.mondayView.trailingAnchor),
            self.tuesdayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            //
            self.tuesdayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tuesdayLabel.centerXAnchor.constraint(equalTo: self.tuesdayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.wednesdayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.wednesdayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.wednesdayView.leadingAnchor.constraint(equalTo: self.tuesdayView.trailingAnchor),
            self.wednesdayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.wednesdayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.wednesdayLabel.centerXAnchor.constraint(equalTo: self.wednesdayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.thursdayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.thursdayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.thursdayView.leadingAnchor.constraint(equalTo: self.wednesdayView.trailingAnchor),
            self.thursdayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.thursdayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.thursdayLabel.centerXAnchor.constraint(equalTo: self.thursdayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.fridayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.fridayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.fridayView.leadingAnchor.constraint(equalTo: self.thursdayView.trailingAnchor),
            self.fridayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.fridayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.fridayLabel.centerXAnchor.constraint(equalTo: self.fridayView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.saturdayView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.saturdayView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            self.saturdayView.leadingAnchor.constraint(equalTo: self.fridayView.trailingAnchor),
            self.saturdayView.widthAnchor.constraint(equalToConstant: self.bounds.width / 8),
            
            self.saturdayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.saturdayLabel.centerXAnchor.constraint(equalTo: self.saturdayView.centerXAnchor)
            ])
    }
}
