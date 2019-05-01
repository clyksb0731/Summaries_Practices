//
//  DayCell.swift
//  Calendar
//
//  Created by 최용석 on 01/05/2019.
//  Copyright © 2019 clyksb0731. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getRGB(240, 240, 240)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getRGB(240, 240, 240)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getRGB(255, 255, 255)
        view.layer.borderColor = UIColor.getRGB(65, 189, 219).cgColor
        view.layer.borderWidth = 2
        view.isHidden = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.getRGB(0, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var dayButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var isAvailable: Bool = false {
        willSet {
            if newValue {
                self.dayLabel.textColor = UIColor.getRGB(0, 0, 0)
                
            } else {
                self.dayLabel.textColor = UIColor.getRGB(208, 208, 208)
            }
            
            self.dayButton.isEnabled = newValue
        }
    }
    
    var selectedDayType: DayType = .normal {
        willSet {
            switch newValue {
            case .aloneSelected:
                self.leftView.isHidden = true
                self.rightView.isHidden = true
                self.circleView.isHidden = false
                self.isAvailable = true
                
            case .start:
                self.leftView.isHidden = true
                self.rightView.isHidden = false
                self.circleView.isHidden = false
                self.isAvailable = true
                
            case .continue:
                self.leftView.isHidden = false
                self.rightView.isHidden = false
                self.circleView.isHidden = true
                self.isAvailable = true
                
            case .end:
                self.leftView.isHidden = false
                self.rightView.isHidden = true
                self.circleView.isHidden = false
                self.isAvailable = true
                
            case .normal:
                self.leftView.isHidden = true
                self.rightView.isHidden = true
                self.circleView.isHidden = true
                self.isAvailable = true
                
            case .notAvailable:
                self.leftView.isHidden = true
                self.rightView.isHidden = true
                self.circleView.isHidden = true
                self.isAvailable = false
            }
        }
    }
    
    var date: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        
        self.setTargets()
        self.setSubviews()
        self.setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension for methods added additionally
extension DayCell {
    func setTargets() {
        self.dayButton.addTarget(self, action: #selector(itemButton(_:)), for: .touchUpInside)
    }
    
    func setSubviews() {
        CoreMethods.shared.addSubviews([
            self.leftView,
            self.rightView,
            self.circleView,
            self.dayLabel,
            self.dayButton], to: self.contentView)
    }
    
    func setLayout() {
        let safeArea = self.contentView.safeAreaLayoutGuide
        self.circleView.layer.cornerRadius =  self.contentView.bounds.height * 0.7 / 2
        
        NSLayoutConstraint.activate([
            self.leftView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.leftView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6),
            self.leftView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.leftView.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.rightView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.rightView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6),
            self.rightView.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.rightView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.circleView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.circleView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.7),
            self.circleView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.circleView.widthAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.7)
            ])
        
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.dayLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.dayLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.dayLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.dayButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.dayButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.dayButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.dayButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
    
    func setItem(year: Int?,
                 month: Int?,
                 day: Int?,
                 dates: [Date]?) {
        
        if let year = year,
            let month = month,
            let day = day,
            let dates = dates {
            self.dayLabel.text = String(day)
            self.date = CoreMethods.shared.getDate(year: year, month: month, day: day)
            self.selectedDayType = CoreMethods.shared.determine(dates: dates, year: year, month: month, day: day)
            
        } else {
            self.dayLabel.text = nil
            self.date = nil
            self.selectedDayType = .notAvailable
        }
    }
}

// MARK: - Extension for objc methods added additionally
extension DayCell {
    @objc func itemButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("determinePeriod"), object: nil, userInfo: ["date":self.date!])
    }
}
