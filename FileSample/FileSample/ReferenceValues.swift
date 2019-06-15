//
//  ReferenceValues.swift
//  FileSample
//
//  Created by Yongseok Choi on 15/06/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import Foundation

class ReferenceValues {
    static var logSerialQueue: DispatchQueue!
    static var logConcurrentQueue: DispatchQueue!
    
    class var reqID: String {
        return CoreMethods.shared.randomString(length: 3) + "\(Int(Date().timeIntervalSinceReferenceDate * 1_000) % 10_000_000)"
    }
}
