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
    
    var isLeapYear: Bool {
        // FIXME: Need to condition for leap year
        return true
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
