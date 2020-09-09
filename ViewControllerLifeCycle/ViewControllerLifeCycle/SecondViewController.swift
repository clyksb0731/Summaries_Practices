//
//  SecondViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Yongseok Choi on 2020/09/04.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToFirstVC(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}
