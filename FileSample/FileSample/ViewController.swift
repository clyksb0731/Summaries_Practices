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
        
        DispatchQueue.global().async {
            var tmpString = "File Manager Test \n"
            //            for index in 1...10_000_000 {
            //                tmpString += "File Manager Test \n"
            //            }
            
            CoreMethods.shared.write(with: tmpString)
        }
    }
    
    
}

