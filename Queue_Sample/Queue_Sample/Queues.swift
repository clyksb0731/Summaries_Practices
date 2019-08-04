//
//  Queues.swift
//  Queue_Sample
//
//  Created by Yongseok Choi on 20/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation

enum StateType {
    case waiting
    case running
}

// MARK: - Push Serial Queue
class PushQueue {
    let pushSerialDispatchQueue: DispatchQueue
    var state: StateType = .waiting
    var queueArray: [[AnyHashable:Any]] = []
    
    init(serialQueue: DispatchQueue? = nil) {
        self.pushSerialDispatchQueue = serialQueue ?? DispatchQueue(label: "pushSerial")
    }
    
    func addQueue(userInfo: [AnyHashable:Any], classifyUserInfo: @escaping (([AnyHashable:Any]) -> Void)) {
        self.pushSerialDispatchQueue.async {
            self.queueArray.append(userInfo)
            if self.state == .waiting {
                self.state = .running
                self.dequeue(classifyUserInfo: classifyUserInfo)
            }
        }
    }
    
    func dequeue(classifyUserInfo: @escaping (([AnyHashable:Any]) -> Void)) {
        self.pushSerialDispatchQueue.async {
            if let firstElement = self.queueArray.first {
                _ = self.queueArray.removeFirst()
                
                classifyUserInfo(firstElement)
                
            } else {
                self.state = .waiting
            }
        }
    }
}

// MARK: - Closure Serial Queue
class SerialQueue {
    var closureSerialDispatchQueue = DispatchQueue(label: "closureSerial")
    var state: StateType = .waiting
    var queueArray: [() -> ()] = []
    
    static let shared = SerialQueue()
    
    private init() {
        
    }
    
    func addQueue(_ closure: @escaping () -> Void) {
        self.closureSerialDispatchQueue.async {
            self.queueArray.append(closure)
            if self.state == .waiting {
                self.state = .running
                self.dequeue()
            }
        }
    }
    
    func dequeue() {
        self.closureSerialDispatchQueue.async {
            if let firstElement = self.queueArray.first {
                _ = self.queueArray.removeFirst() // not call by reference but call by value
                
                firstElement()
                
            } else {
                self.state = .waiting
            }
        }
    }
}

// MARK: - Serial queue made for test initially
class SerialQueue2 {
    var state: StateType = .waiting
    var queueArray: [() -> ()] = []
    
    static let shared = SerialQueue2()
    
    private init() {
        
    }
    
    func addQueue(_ closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.queueArray.append(closure)
            if self.state == .waiting {
                self.excuteElement()
            }
        }
    }
    
    func excuteElement() {
        self.state = .waiting
        
        if let firstElement = self.queueArray.first {
            self.state = .running
            
            _ = self.queueArray.removeFirst()
            
            firstElement()
        }
    }
}
