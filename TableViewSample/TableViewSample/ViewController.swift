//
//  ViewController.swift
//  TableViewSample
//
//  Created by 최용석 on 28/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nextVC = NextViewController()
        
        self.present(nextVC, animated: true)
    }
}
