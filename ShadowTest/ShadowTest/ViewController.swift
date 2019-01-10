//
//  ViewController.swift
//  ShadowTest
//
//  Created by 최용석 on 11/12/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tmpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tmpView.backgroundColor = .yellow
        tmpView.layer.shadowColor = UIColor.black.cgColor
        tmpView.layer.shadowOffset = .zero
        tmpView.layer.shadowOpacity = 0.6
        tmpView.layer.shadowRadius = 15
        tmpView.layer.shadowPath = UIBezierPath(rect: tmpView.bounds).cgPath
    
    }


}

