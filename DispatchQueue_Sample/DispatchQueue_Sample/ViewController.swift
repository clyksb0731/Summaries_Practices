//
//  ViewController.swift
//  DispatchQueue_Sample
//
//  Created by Yongseok Choi on 14/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let concurrentQueue = DispatchQueue(label: "concurrrent", attributes: .concurrent)
        let serialQueue = DispatchQueue(label: "serialQueue")
        
        concurrentQueue.async {
            for index in 0..<3000 {
                self.queue(on: serialQueue, value: index)
            }
        }
        
    }


}

extension ViewController {
    func queue(on: DispatchQueue, value: Int) {
        on.async {
            print("result: ", value)
        }
    }
}

