//
//  ViewController.swift
//  Autolayout
//
//  Created by 최용석 on 04/03/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var subView: UIView = {
        let subView = UIView()
        subView.backgroundColor = UIColor.yellow
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        return subView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSubViews()
        self.setLayout()
        
        self.label.text = "dfafdasadfadfadfadfadfadfadfadfadfadfadfadfadfadsfasdfasdfasdfasdfasdfadsfadfg"
    }
    
    func setSubViews() {
        self.view.addSubview(self.subView)
        self.subView.addSubview(self.label)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([self.subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                                     self.subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                                     self.subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                                     self.subView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)])
        
        NSLayoutConstraint.activate([self.label.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 10),
                                     self.label.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: -10),
                                     self.label.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 10),
                                     self.label.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: -10),
                                     self.label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)])
    }
}

