//
//  RealmDB.swift
//  FileManagerSample
//
//  Created by 최용석 on 08/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import Foundation
import RealmSwift

enum DebugType: String {
    case debug = "DEBUG"
    case error = "ERROR"
}

@objcMembers
class Debug: Object {
    dynamic var sequence: Int = 0
    dynamic var type: String = ""
    dynamic var action: String = ""
    dynamic var localizedDescription: String = ""
    dynamic var date: Date = Date()
    dynamic var file: String = ""
    dynamic var function: String = ""
    dynamic var lineOfCode: Int = 0
    dynamic var requestID: String = ""
    
    convenience init(_ sequence: Int, _ type: DebugType, _ action: String, _ description: String, _ file: String, _ function: String, _ lineOfCode: Int, _ requestID: String) {
        self.init()
        
        self.sequence = sequence
        
        switch type {
        case .debug:
            self.type = DebugType.debug.rawValue
        case .error:
            self.type = DebugType.error.rawValue
        }
        
        self.action = action
        self.localizedDescription = description
        self.date = Date()
        self.file = file
        self.function = function
        self.lineOfCode = lineOfCode
        self.requestID = requestID
    }
    
    func showMe() {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatted.locale = Locale.current
        let dateLocalized = dateFormatted.string(from: self.date)
        
        print("[\(self.type), Action: \(self.action), Description: \(self.localizedDescription), Date: \(dateLocalized), File: \(self.file), Function: \(self.function), LineOfCode: \(self.lineOfCode), Request ID: \(self.requestID)]")
    }
}
