//
//  Queues.swift
//  Queue_Sample
//
//  Created by Yongseok Choi on 20/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation

class SerialQueue {
    enum StateType {
        case waiting
        case inProgress
    }
    
    var state: StateType = .waiting
    var queueArray: [() -> ()] = []
    
    static let share = SerialQueue()
    
    private init() {
        
    }
    
    func addQueue(_ closure: @escaping () -> Void) {
        self.queueArray.append(closure)
        if self.state == .waiting {
            self.excuteElement()
        }
    }
    
    func excuteElement() {
        if let firstElement = self.queueArray.first {
            self.state = .inProgress
            
            _ = self.queueArray.removeFirst()
            
            firstElement()
        }
    }
}
