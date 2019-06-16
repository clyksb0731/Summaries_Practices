//
//  ViewController.swift
//  FileSample
//
//  Created by 최용석 on 11/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func makeLog(_ sender: UIButton) {
        for _ in 1...100 {
            for _ in 1...100000 {
                
            }
            
            CoreMethods.shared.makeDebugLogIntoFile(.debug, "Touch button on view", requestID: ReferenceValues.reqID)
        }
        // without term, only by user.
//        CoreMethods.shared.makeDebugLogIntoFile(.debug, "Touch button on view", requestID: ReferenceValues.reqID)
    }
    
    @IBAction func makeTempDebug(_ sender: UIButton) {
        for _ in 1...100 {
//            for _ in 1...100000 {
//                
//            }
            
            CoreMethods.shared.makeDebugLogTemporarily(.debug, "Touch button For temp on view", requestID: ReferenceValues.reqID)
        }
        // without term, only by user.
//            CoreMethods.shared.makeDebugLogTemporarily(.debug, "Touch button For temp on view", requestID: ReferenceValues.reqID)
    }
    
    
}

extension ViewController {
    
    
    
}

