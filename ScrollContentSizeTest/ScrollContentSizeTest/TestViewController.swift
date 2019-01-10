//
//  TestViewController.swift
//  ScrollContentSizeTest
//
//  Created by 최용석 on 11/01/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.boxView)
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!)
        
        self.scrollView.contentSize = CGSize(width: 375, height: 724)
        
        self.view.backgroundColor = .white
        
        self.setLayout()
    }
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    var boxView: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = .red
        boxView.translatesAutoresizingMaskIntoConstraints = false
        
        return boxView
    }()
    
    func setLayout() {
        let safeArea = UILayoutGuide()
        self.view.addLayoutGuide(safeArea)
        safeArea.identifier = "safeArea"
        
        NSLayoutConstraint.activate([safeArea.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!),
                                     safeArea.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     safeArea.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     safeArea.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                     self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                                     self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                     self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
        
        NSLayoutConstraint.activate([self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.contentView.heightAnchor.constraint(equalToConstant: self.scrollView.contentSize.height),
                                     self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     self.contentView.widthAnchor.constraint(equalToConstant: self.scrollView.contentSize.width)])
        
        NSLayoutConstraint.activate([self.boxView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
                                     self.boxView.heightAnchor.constraint(equalToConstant: 35),
                                     self.boxView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
                                     self.boxView.widthAnchor.constraint(equalToConstant: 50)])
    }

}
