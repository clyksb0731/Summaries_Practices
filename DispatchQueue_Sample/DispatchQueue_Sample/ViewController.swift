//
//  ViewController.swift
//  DispatchQueue_Sample
//
//  Created by Yongseok Choi on 14/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    var memberArray: [String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    
    var timeFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = ""
    }
    
    
    @IBAction func startTimeAppear(_ sender: UIButton) {
        self.timeFlag = false
        self.startTimeOnView()
    }
    
    @IBAction func stopTimeAppear(_ sender: UIButton) {
        self.timeFlag = true
    }
    
}

// MARK: Test for thread safety
extension ViewController {
    func startTimeOnView() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        let concurrentQueue = DispatchQueue(label: "concorrentQueue", attributes: .concurrent)
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatted.locale = Locale.current
        
        // Using async which contains sync block can prevent freezing system.
        serialQueue.async {
            concurrentQueue.sync {
                var date: Date!
                while true {
                    if self.timeFlag {
                        break
                    }
                    
                    date = Date()
                    DispatchQueue.main.async {
                        self.timeLabel.text = dateFormatted.string(from: date)
                    }
                }
            }
        }
        
        // sync mode can freeze system even though using concurrent
//        concurrentQueue.async {
//            var date: Date!
//            while true {
//                if self.timeFlag {
//                    break
//                }
//
//                date = Date()
//                DispatchQueue.main.async {
//                    self.timeLabel.text = dateFormatted.string(from: date)
//                }
//            }
//        }
        
    }
    
    func oldTest() {
        let baseConcurrentQueue = DispatchQueue(label: "baseConcurrrent", attributes: .concurrent)
        let concurrentQueue = DispatchQueue(label: "concurrrent", attributes: .concurrent)
        let serialQueue = DispatchQueue(label: "serial")
        
        baseConcurrentQueue.async {
            for _ in 0..<1000 {
                //                self.queue(on: serialQueue, value: index)
                //                self.queue2(on: concurrentQueue)
                //                self.queue3(on: serialQueue)
                self.queue4(on: concurrentQueue)
            }
        }
        
        for _ in 0..<1000 {
            print("***** sync concurrent *****")
        }
    }
    
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

// MARK: Test for sync async of thread
extension ViewController {
    func queue4(on: DispatchQueue) {
        on.sync {
            for _ in 1...50{
                 print("On concurrent: ", self.memberArray[2])
            }
            
        }
    }
}
