//
//  PartitionLibraries.swift
//  ProgressView
//
//  Created by 최용석 on 09/04/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import Foundation

protocol PartitionDelegate {
    func receive(currentValue: Float)
}

class Partition {
    var maxCount: Int = 1000_000
    var progress: [Float] = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
    var interval: Int = 0
    
    var delegate: PartitionDelegate?
    
    init() {
    }
    
    convenience init(interval: Int) {
        self.init()
        
        self.interval = interval
    }
    
    func start() {
        DispatchQueue.global().async {
            for factor in self.progress {
                for _ in 0...self.interval { }
                DispatchQueue.main.async {
                    self.delegate?.receive(currentValue: factor)
                }
            }
        }
    }
}
