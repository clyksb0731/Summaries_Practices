//
//  ViewController.swift
//  ScrollContentSizeTest
//
//  Created by 최용석 on 11/01/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tmpVC = TestViewController()
        let navi = UINavigationController(rootViewController: tmpVC)
        
        self.present(navi, animated: true)
    }



}

