//
//  ViewController.swift
//  SubviewTest
//
//  Created by Yongseok Choi on 2021/04/17.
//

import UIKit

class ViewController: UIViewController {

    var testSubview: TestSubview = {
        let view = TestSubview()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var showUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Up", for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.showUpButton.addTarget(self, action: #selector(showUpButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(self.testSubview)
        self.view.addSubview(self.showUpButton)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.testSubview.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.testSubview.heightAnchor.constraint(equalToConstant: 300),
            self.testSubview.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.testSubview.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        let defaultYAxisConstraint = self.showUpButton.topAnchor.constraint(equalTo: self.testSubview.bottomAnchor, constant: 30)
        defaultYAxisConstraint.priority = UILayoutPriority(1000)
        let anotherYAxisConstraint = self.showUpButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        anotherYAxisConstraint.priority = UILayoutPriority(750)
        NSLayoutConstraint.activate([
            defaultYAxisConstraint,
            anotherYAxisConstraint,
            self.showUpButton.heightAnchor.constraint(equalToConstant: 50),
            self.showUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.showUpButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func showUpButton(_ sender: UIButton) {        
        guard !self.view.subviews.contains(self.testSubview) else {
            return
        }
        
        self.view.addSubview(self.testSubview)
        let safeArea = self.view.safeAreaLayoutGuide
        
        let defaultYAxisConstraint = self.showUpButton.topAnchor.constraint(equalTo: self.testSubview.bottomAnchor, constant: 30)
        defaultYAxisConstraint.priority = UILayoutPriority(1000)
        
        NSLayoutConstraint.activate([
            self.testSubview.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.testSubview.heightAnchor.constraint(equalToConstant: 300),
            self.testSubview.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.testSubview.widthAnchor.constraint(equalToConstant: 300),
            
            // for show up button
            defaultYAxisConstraint
        ])
    }
}

