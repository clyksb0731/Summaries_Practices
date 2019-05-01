//
//  DayCell.swift
//  Calendar
//
//  Created by 최용석 on 01/05/2019.
//  Copyright © 2019 clyksb0731. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var date: (year: Int, month: Int, day: Int)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.dayLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Position {
        case left
        case middle
        case right
    }
    
    func setLayout(_ position: Position) {
        let safeArea = self.contentView.safeAreaLayoutGuide
        
        switch position {
        case .left:
            NSLayoutConstraint.activate([
                self.dayLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
                self.dayLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                self.dayLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: self.contentView.bounds.width / 3),
                self.dayLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
                ])
            
        case .middle:
            NSLayoutConstraint.activate([
                self.dayLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
                self.dayLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                self.dayLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                self.dayLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
                ])
            
        case .right:
            NSLayoutConstraint.activate([
                self.dayLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
                self.dayLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                self.dayLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                self.dayLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(self.contentView.bounds.width / 3))
                ])
            
        }
    }
    
    func setDayLabel(_ day: Int) {
        self.dayLabel.text = String(day)
    }
    
    func setDate(year: Int, month: Int, day: Int) {
        self.date = (year: year, month: month, day: day)
    }
}
