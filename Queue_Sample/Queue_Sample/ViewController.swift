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
        
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 1, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 2, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 3, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 4, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 5, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 6, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 7, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 8, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 9, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 10, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 11, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 12, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 13, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 14, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 15, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 16, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 17, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 18, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 19, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 20, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 21, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 22, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 23, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 24, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 25, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 26, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 27, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 28, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 29, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
        SerialQueue.shared.addQueue {
            self.asynFunction(value: 30, completion: {
                SerialQueue.shared.dequeue()
            })
        }
        
    }

    func asynFunction(value: Int, completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            for _ in 1...10_000 {
                
            }
            
            print("Value: ", value)
            
            completion()
        }
    }

}

