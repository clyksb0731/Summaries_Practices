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
    
    func getYearMonthOf(_ date: Date = Date()) -> (year: Int, month: Int)? {
        let dateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        if let year = dateComponent.year,
            let month = dateComponent.month {
            
            return (year: year, month: month)
            
        } else {
            return nil
        }
    }
    
    func getWeekday(year: Int, month: Int, day: Int) -> Int? {
        if let date = self.getDate(year: year, month: month, day: day),
            let weekday = Calendar.current.dateComponents(in: TimeZone.current, from: date).weekday {
            
            return weekday
            
        } else {
            return nil
        }
    }
    
    func getEndDay(year: Int, month: Int) -> Int {
        if month == 1 ||
            month == 3 ||
            month == 5 ||
            month == 7 ||
            month == 8 ||
            month == 10 ||
            month == 12 {
            
            return 31
            
        } else if month == 4 ||
            month == 6 ||
            month == 9 ||
            month == 11 {
            
            return 30
            
        } else {
            if year % 4 == 0 {
                if year % 100 == 0 {
                    if year % 400 == 0 {
                        return 29
                        
                    } else {
                        return 28
                    }
                    
                } else {
                    return 29
                }
                
            } else {
                return 28
            }
        }
    }
    
    // FIXME: Modify and apply and complete DateGenrator
    func getEndDay(date: Date, month: Int) -> Int? {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count
    }
    
    func previousYearMonth(year: Int, month: Int) -> (year: Int, month: Int) {
        if month == 1 {
            return (year: year - 1, month: 12)
            
        } else {
            return (year: year, month: month - 1)
        }
    }
    
    func determine(dates: [Date], year: Int, month: Int, day: Int) -> DayType {
        var dayType: DayType!
        if self.getDate(year: year, month: month, day: day)! > Date() {
            dayType = .notAvailable
            
        } else {
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
        }
        
        return dayType
    }

}

extension UIColor {
    static func getRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
