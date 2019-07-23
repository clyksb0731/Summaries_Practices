//
//  DynamicScrollViewController.swift
//  ScrollView
//
//  Created by Yongseok Choi on 23/07/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class DynamicScrollViewController: UIViewController {

    var scrollView: UIScrollView!
    var contentView: UIView!
    var firstLabel: UILabel!
    var secondLabel: UILabel!
    var firstView: UIView!
    
    var checkHeightOfDynamicContentHeight: CGFloat = 1500 // to see dynamic content size.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.initializeViews()
        self.setViews()
        self.setLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Content OffSize: ", self.scrollView.contentSize)
    }
    
    func initializeViews() {
        self.scrollView = {
            let scrollView = UIScrollView()
            scrollView.bounces = false
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            return scrollView
        }()
        
        self.contentView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.firstLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "First Text"
            label.textColor = .white
            label.backgroundColor = .blue
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        self.secondLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "Second Text"
            label.textColor = .white
            label.backgroundColor = .red
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        self.firstView = {
            let view = UIView()
            view.backgroundColor = .green
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
    }
    
    func setViews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.firstLabel)
        self.contentView.addSubview(self.secondLabel)
        self.contentView.addSubview(self.firstView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
        let contentHeightConstraint: NSLayoutConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor) // Key point
        contentHeightConstraint.priority = UILayoutPriority(1) // Key point
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentHeightConstraint,
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor) // Key point
            ])
        
        NSLayoutConstraint.activate([
            self.firstLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100),
            self.firstLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.secondLabel.topAnchor.constraint(equalTo: self.firstLabel.bottomAnchor, constant: 200),
            self.secondLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.firstView.topAnchor.constraint(equalTo: self.secondLabel.bottomAnchor, constant: 200),
            self.firstView.heightAnchor.constraint(equalToConstant: self.checkHeightOfDynamicContentHeight),
            self.firstView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor), // Key point for dynamic content size (height) to the position of bottom
            self.firstView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.firstView.widthAnchor.constraint(equalToConstant: 250)
            ])
    }

}
