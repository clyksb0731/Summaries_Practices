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
        
        
        SerialQueue.share.addQueue {
            self.asynFunction(value: 1, completion: {
                SerialQueue.share.excuteElement()
            })
        }
        
        SerialQueue.share.addQueue {
            self.asynFunction(value: 2, completion: {
                SerialQueue.share.excuteElement()
            })
        }
        
        SerialQueue.share.addQueue {
            self.asynFunction(value: 3, completion: {
                SerialQueue.share.excuteElement()
            })
        }
        
        SerialQueue.share.addQueue {
            self.asynFunction(value: 4, completion: {
                SerialQueue.share.excuteElement()
            })
        }
        
        SerialQueue.share.addQueue {
            self.asynFunction(value: 5, completion: {
                SerialQueue.share.excuteElement()
            })
        }
    }

    func asynFunction(value: Int, completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            for _ in 1...10_000 {
                
            }
            
            print("Value: ", value)
            
            SerialQueue.share.state = .waiting
            completion()
        }
    }

}

