//
//  CoreMethods.swift
//  FileSample
//
//  Created by 최용석 on 11/05/2019.
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
    
    // MARK: Make Debug Log into File
    func makeDebugLogIntoFile(_ type: DebugType, _ action: String, _ description: String = "none", requestID: String = "none", _ file: String = #file, _ function: String = #function, _ lineOfCode: Int = #line, date: Date = Date()) {
        
        if ReferenceValues.logSerialQueue == nil {
            ReferenceValues.logSerialQueue = DispatchQueue(label: "logSerialQueue")
        }
        
        if ReferenceValues.logConcurrentQueue == nil {
            ReferenceValues.logConcurrentQueue = DispatchQueue(label: "logCocurrentQueue", attributes: .concurrent)
        }
        
        ReferenceValues.logSerialQueue.async {
            ReferenceValues.logConcurrentQueue.sync {
                let dateFormatted = DateFormatter()
                dateFormatted.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                dateFormatted.locale = Locale.current
                let dateLocalized = dateFormatted.string(from: date)
                
                let log: String = "[\(type.rawValue), Action: \(action), Description: \(description), Date: \(dateLocalized), TimeIntervalSince1970: \(date.timeIntervalSince1970 * 1_000)ms, File: \(file), Function: \(function), LineOfCode: \(lineOfCode), Request ID: \(requestID)]\n\n"
                
                dateFormatted.dateFormat = "yyyy-MM-dd"
                dateFormatted.locale = Locale.current
                let logDateName = dateFormatted.string(from: date)
                
                let fileManager: FileManager = FileManager.default
                
                if let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let logDirectoryURL = documentURL.appendingPathComponent("DebugLogs", isDirectory: true)
                    let logFileURL = logDirectoryURL.appendingPathComponent(logDateName).appendingPathExtension("txt")
                    
                    if fileManager.fileExists(atPath: logFileURL.path) {
                        if let fileHandle = FileHandle(forWritingAtPath: logFileURL.path) {
                            if let logData = log.data(using: .utf8) {
                                print("File Size: ", fileHandle.seekToEndOfFile())
//                                fileHandle.waitForDataInBackgroundAndNotify()
                                fileHandle.write(logData)
                                fileHandle.closeFile()
                                
                                print(log)
                                
                            } else {
                                print("Data converting error")
                            }
                            
                        } else {
                            print("fail to write log")
                        }
                        
                    } else {
                        if let _ = try? fileManager.createDirectory(at: logDirectoryURL, withIntermediateDirectories: false, attributes: nil) {
                            if fileManager.createFile(atPath: logFileURL.path, contents: log.data(using: .utf8), attributes: nil) {
                                print(log)
                                
                            } else {
                                print("Failed to be logged at creating file")
                            }
                            
                        } else {
                            print("Failed to be logged at creating directory")
                        }
                    }
                    
                } else {
                    print("FileManager doesn't work")
                }
            }
        }
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
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
}
