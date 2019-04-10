//
//  DateGenerator.swift
//  Calendar
//
//  Created by 최용석 on 2018. 6. 18..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import Foundation

class DateGenerator {
    
    private let dayInterval: Double = 86400 // seconds a day
    
    private var date: Date = Date()
    
    init() {
        
    }
    
    convenience init(date: Date) {
        self.init()
        
        self.date = date
    }
    
    /*
     서력 기원 연수가 4로 나누어떨어지는 해는 윤년으로 한다. (1992년, 1996년, 2004년, 2008년, 2012년, 2016년, 2020년, 2024년, 2028년 ...)
     서력 기원 연수가 4, 100으로 나누어떨어지는 해는 평년으로 한다. (1900년, 2100년, 2200년, 2300년, 2500년...)
     서력 기원 연수가 4, 100, 400으로 나누어떨어지는 해는 윤년으로 둔다. (1600년, 2000년, 2400년...)
     */
    
    // FIXME: Should be changed to be correct.
    var isLeapYear: Bool {
        if let year = self.getYear() {
            if year % 4 == 0 {
                if year % 100 == 0 {
                    if year % 400 == 0 {
                        
                    }
                }
            }
        }
        
        return false
    }
    
    func getYear() -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: self.date).year
    }
    
    func getMonth() -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: self.date).month
    }
    
    func getDay() -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: self.date).year
    }
    
    func getYear(backward days: Int) -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: Date(timeInterval: -1 * (Double(days) * self.dayInterval), since: self.date)).year
    }
    
    func getMonth(backward days: Int) -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: Date(timeInterval: -1 * (Double(days) * self.dayInterval), since: self.date)).month
    }
    
    func getDay(backward days: Int) -> Int? {
        return Calendar.current.dateComponents(in: TimeZone.current, from: Date(timeInterval: -1 * (Double(days) * self.dayInterval), since: self.date)).day
    }
    
//    func tmpPrintDateComponent() {
//        print("\(self.getDateComponents().year!)년, \(self.getDateComponents().month!)월, \(self.getDateComponents().day!)일")
//    }
}
