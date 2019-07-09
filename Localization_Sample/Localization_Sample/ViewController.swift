//
//  ViewController.swift
//  Localization_Sample
//
//  Created by Yongseok Choi on 06/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 10
    
    var localizedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dynamic localizable.
        self.localizedLabel.text = String(format: NSLocalizedString("%d new one", comment: ""), self.count)
    }


}

