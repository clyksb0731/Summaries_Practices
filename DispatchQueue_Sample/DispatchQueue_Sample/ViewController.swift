//
//  ViewController.swift
//  DispatchQueue_Sample
//
//  Created by Yongseok Choi on 14/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var memberArray: [String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseConcurrentQueue = DispatchQueue(label: "baseConcurrrent", attributes: .concurrent)
        let concurrentQueue = DispatchQueue(label: "concurrrent", attributes: .concurrent)
        let serialQueue = DispatchQueue(label: "serialQueue")
        
        baseConcurrentQueue.async {
            for index in 0..<1000 {
//                self.queue(on: serialQueue, value: index)
                self.queue2(on: concurrentQueue)
                self.queue3(on: serialQueue)
            }
        }
        
    }


}

// MARK: Test for thread safety
extension ViewController {
    func queue(on: DispatchQueue, value: Int) {
        DispatchQueue.main.async {
            print("result: ", value)
        }
    }
    
    func queue2(on: DispatchQueue) {
        on.async {
            for _ in 1...50{
                print("On concurrent: ", self.memberArray[1])
            }
            
        }
    }
    
    func queue3(on: DispatchQueue) {
        on.async {
            for _ in 1...50{
                self.memberArray[1] = "new one"
            }
            
        }
    }
}
