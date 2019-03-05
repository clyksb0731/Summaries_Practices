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
    
    var previousView: UIView = {
        let previousView = UIView()
        previousView.backgroundColor = .green
        previousView.translatesAutoresizingMaskIntoConstraints = false
        
        return previousView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var subView2: UIView = {
        let subView = UIView()
        subView.backgroundColor = UIColor.blue
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        return subView
    }()
    
    var previousView2: UIView = {
        let previousView = UIView()
        previousView.backgroundColor = .green
        previousView.translatesAutoresizingMaskIntoConstraints = false
        
        return previousView
    }()
    
    var label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSubViews()
        self.setLayout()
        
        self.label.text = "abcdefghijklmnopqr"
        self.label2.text = "adlkgjalkjglajlgj"
    }
    
    func setSubViews() {
        self.view.addSubview(self.subView)
        self.subView.addSubview(self.previousView)
        self.subView.addSubview(self.label)
        
        self.view.addSubview(self.subView2)
        self.subView2.addSubview(self.previousView2)
        self.subView2.addSubview(self.label2)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([self.subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                                     self.subView.heightAnchor.constraint(equalToConstant: 20),
                                     self.subView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                     self.subView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)])
        
        NSLayoutConstraint.activate([self.previousView.centerYAnchor.constraint(equalTo: self.subView.centerYAnchor),
                                     self.previousView.heightAnchor.constraint(equalToConstant: 18),
                                     self.previousView.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 5),
                                     self.previousView.widthAnchor.constraint(equalToConstant: 18)])
        
        NSLayoutConstraint.activate([self.label.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 1),
                                     self.label.heightAnchor.constraint(equalToConstant: 18),
                                     self.label.leadingAnchor.constraint(equalTo: self.previousView.trailingAnchor, constant: 5),
                                     self.label.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: -10)])
        
        //////////////////////////////////////////////
        
        NSLayoutConstraint.activate([self.subView2.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 100),
                                     self.subView2.heightAnchor.constraint(equalToConstant: 20),
                                     self.subView2.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                     self.subView2.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)])
        
        NSLayoutConstraint.activate([self.previousView2.centerYAnchor.constraint(equalTo: self.subView2.centerYAnchor),
                                     self.previousView2.heightAnchor.constraint(equalToConstant: 18),
                                     self.previousView2.leadingAnchor.constraint(equalTo: self.subView2.leadingAnchor, constant: 5),
                                     self.previousView2.widthAnchor.constraint(equalToConstant: 18)])
        
        NSLayoutConstraint.activate([self.label2.topAnchor.constraint(equalTo: self.subView2.topAnchor, constant: 1),
                                     self.label2.heightAnchor.constraint(equalToConstant: 18),
                                     self.label2.leadingAnchor.constraint(equalTo: self.previousView2.trailingAnchor, constant: 5),
                                     self.label2.trailingAnchor.constraint(equalTo: self.subView2.trailingAnchor, constant: -10)])
    }
}

