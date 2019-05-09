//
//  CoreMethods.swift
//  FileManagerSample
//
//  Created by 최용석 on 09/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import RealmSwift

class CoreMethods {
    static let shared = CoreMethods()
    
    private init() {
        
    }
    
    // MARK: File Manager
    func write(with content: String) {
        let fileManager: FileManager = FileManager.default

        if let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let logDirectoryURL = documentURL.appendingPathComponent("DebugLogs", isDirectory: true)
            try? fileManager.createDirectory(at: logDirectoryURL, withIntermediateDirectories: false, attributes: nil)
            let logFileURL = logDirectoryURL.appendingPathComponent(self.getToday() + "-new").appendingPathExtension("log")
            
            if fileManager.fileExists(atPath: logFileURL.path) {
                print("File already exists")
                
            } else {
                try? content.write(to: logFileURL, atomically: false, encoding: .utf8)
                print("File is made just before")
            }
        }
    }
    
    // MARK: Get today
    func getToday() -> String {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd"
        dateFormatted.locale = Locale.current
        let dateLocalized = dateFormatted.string(from: Date())
        
        return dateLocalized
    }
    
    // MARK: Make Debug Log
    func makeDebugLog(_ type: DebugType, _ action: String, _ description: String = "none", requestID: String = "none", _ file: String = #file, _ function: String = #function, _ lineOfCode: Int = #line) {
        
        do {
            let realm = try Realm()
            
            let count = realm.objects(Debug.self).count
            let debugLog = Debug(count, type, action, description, URL(fileURLWithPath: file).lastPathComponent, function, lineOfCode, requestID)
            
            try realm.write {
                realm.add(debugLog)
            }
            
            debugLog.showMe()
            
        } catch let error as NSError {
            print("Error Occurs when debug log is saved into DB: ", error.localizedDescription)
        }
    }
    
}
