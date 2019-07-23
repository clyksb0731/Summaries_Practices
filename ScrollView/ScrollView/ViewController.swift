//
//  ViewController.swift
//  ScrollView
//
//  Created by Yongseok Choi on 11/10/2018.
//  Copyright © 2018 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openDynamicVC(_ sender: UIButton) {
        let dynamicVC = DynamicScrollViewController()
        
        self.present(dynamicVC, animated: true)
    }
    
    @IBAction func openLegacyVC(_ sender: UIButton) {
        let legacyVC = YellowScrollViewController()
        
        self.present(legacyVC, animated: true)
    }
    

}

