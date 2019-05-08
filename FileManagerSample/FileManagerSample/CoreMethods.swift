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
        var root = fileManager.currentDirectoryPath
        print("Current Directory::::: ", root)
            
        if let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            print("Document Directory::::: ", documentURL)
            fileManager.changeCurrentDirectoryPath(documentURL)
            print("Current Directory::::: ", root)
            root = fileManager.currentDirectoryPath
            print("Current Directory changed::::: ", root)
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
    
}
