//
//  ViewController.swift
//  FileManagerSample
//
//  Created by 최용석 on 08/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreMethods.shared.write(with: "")
    }


}

