//
//  CoreMethods.swift
//  Calendar
//
//  Created by 최용석 on 01/05/2019.
//  Copyright © 2019 clyksb0731. All rights reserved.
//

import UIKit

enum DayType {
    case aloneSelected
    case start
    case `continue`
    case end
    case normal
    case notAvailable
}

class CoreMethods {
    static let shared: CoreMethods = CoreMethods()
    
    private init() {
        
    }
    
    func addSubviews(_ views: [UIView], to view: UIView) {
        for elementView in views {
            view.addSubview(elementView)
        }
    }
    
    func getDate(year: Int, month: Int, day: Int) -> Date? {
        return DateComponents(calendar: Calendar.current, year: year, month: month, day: day).date
    }
    
    func determine(dates: [Date], year: Int, month: Int, day: Int) -> DayType {
        var dayType: DayType!
        if dates.isEmpty {
            dayType = .normal
            
        } else if dates.count == 1 {
            if self.getDate(year: year, month: month, day: day) == dates[0] {
                dayType = .aloneSelected
                
            } else {
                dayType = .normal
            }
            
        } else if dates.count == 2 {
            if self.getDate(year: year, month: month, day: day) == dates[0] {
                dayType = .start
                
            } else if self.getDate(year: year, month: month, day: day) == dates[1] {
                dayType = .end
                
            } else if self.getDate(year: year, month: month, day: day)! > dates[0] &&
                self.getDate(year: year, month: month, day: day)! < dates[1] {
                dayType = .continue
                
            } else {
                dayType = .normal
            }
        }
        
        return dayType
    }
    
}

extension UIColor {
    static func getRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
