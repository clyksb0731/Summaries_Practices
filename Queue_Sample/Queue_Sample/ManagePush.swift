//
//  ManagePush.swift
//  Queue_Sample
//
//  Created by Yongseok Choi on 04/08/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation

class ManagePush {
    var pushQueue = PushQueue()
    let pushedCodes = [
        100,
        200,
        300,
        100,
        100,
        100,
        300,
        400,
        200,
        200,
        300,
        100,
        500,
        100,
        100,
        300
    ]
    
    func mangePushNotification() {
        for code in self.pushedCodes {
            self.pushQueue.addQueue(userInfo: ["code":code],
                                    classifyUserInfo: self.classifyUserInfo)
        }
    }
    
    func classifyUserInfo(_ userInfo: [AnyHashable:Any]) {
        guard let code = userInfo["code"] as? Int else {
            return
        }
        
        if code == 100 {
            self.firstHandle {
                self.pushQueue.dequeue(classifyUserInfo: self.classifyUserInfo)
            }
            
        } else if code == 200 {
            self.secondHandle {
                self.pushQueue.dequeue(classifyUserInfo: self.classifyUserInfo)
            }
            
        } else if code == 300 {
            self.thirdHandle {
                self.pushQueue.dequeue(classifyUserInfo: self.classifyUserInfo)
            }
            
        } else {
            self.othersHandle {
                self.pushQueue.dequeue(classifyUserInfo: self.classifyUserInfo)
            }
        }
        
        
    }
    
    func firstHandle(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            self.firtNext(completion: completion)
        }
    }
    
    func firtNext(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            self.firstNextNext(completion: completion)
        }
    }
    
    func firstNextNext(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            print("first")
            
            completion?()
        }
    }
    
    func secondHandle(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            print("second")
            
            completion?()
        }
    }
    
    func thirdHandle(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            self.thirdNext(completion: completion)
        }
    }
    
    func thirdNext(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            print("third")
            
            completion?()
        }
    }
    
    func othersHandle(completion: (() -> ())?) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            print("others")
            
            completion?()
        }
    }
}
