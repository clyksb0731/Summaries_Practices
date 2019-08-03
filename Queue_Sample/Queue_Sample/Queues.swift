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
                _ = self.queueArray.removeFirst()
                
                firstElement()
                
            } else {
                self.state = .waiting
            }
        }
    }
}

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
