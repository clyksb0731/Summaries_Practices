//
//  YellowScrollViewController.swift
//  ScrollView
//
//  Created by Yongseok Choi on 23/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class YellowScrollViewController: UIViewController {
    
    var safeGuide: UILayoutGuide!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var fLb: UILabel!
    var sLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.safeGuide = self.view.safeAreaLayoutGuide
        //        let scrollGuide: UILayoutGuide = self.scrollView.safeAreaLayoutGuide
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = .yellow
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1500)
        self.scrollView.bounces = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)
        
        self.contentView = UIView()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.contentView)
        
        
        self.fLb = UILabel()
        self.fLb.text = "First"
        self.fLb.textAlignment = .center
        self.fLb.textColor = .black
        self.fLb.backgroundColor = .gray
        self.fLb.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.fLb)
        
        self.sLb = UILabel()
        self.sLb.text = "Second"
        self.sLb.textAlignment = .center
        self.sLb.textColor = .black
        self.sLb.backgroundColor = .gray
        self.sLb.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.sLb)
        
        // Set scroll view anchor
        self.scrollView.topAnchor.constraint(equalTo: self.safeGuide.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.safeGuide.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.safeGuide.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.safeGuide.trailingAnchor).isActive = true
        
        // Set contentView anchor
        self.contentView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        
        self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
        
        // Set first label anchor on scroll view
        self.fLb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.fLb.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.fLb.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.fLb.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        
        // Set second label anchor on scroll view
        self.sLb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.sLb.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.sLb.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.sLb.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1000).isActive = true
    }
    
    
}
