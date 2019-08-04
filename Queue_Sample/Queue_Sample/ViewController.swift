//
//  ViewController.swift
//  Queue_Sample
//
//  Created by Yongseok Choi on 20/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managePush = ManagePush()
        
//        self.testSerialQueue(times: 30) // to test closure serial queque
        managePush.mangePushNotification() // to test push serial queue
        
    }
    
    
}

// MARK: - Test for serial queue
extension ViewController {
    func testSerialQueue(times: Int) {
        for index in 1...times {
            SerialQueue.shared.addQueue {
                self.asynFunction(value: index, completion: {
                    SerialQueue.shared.dequeue()
                })
            }
        }
    }
    
    func asynFunction(value: Int, completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            for _ in 1...1000_000 {
                
            }
            
            print("Value: ", value)
            
            completion()
        }
    }
}

