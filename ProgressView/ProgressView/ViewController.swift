//
//  ViewController.swift
//  ProgressView
//
//  Created by 최용석 on 09/04/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .white
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.progressTintColor = .blue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    var countTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.placeholder = "Interval (higher, slower)"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var runButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var resetButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var partitionObject: Partition = {
        let partitionObject = Partition()
        
        return partitionObject
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        partitionObject.delegate = self
        
        self.setTargets()
        self.addSubviews()
        self.setLayout()
    }
    
    
    func addSubviews() {
        self.view.addSubview(self.progressView)
        self.view.addSubview(self.countTextField)
        self.view.addSubview(self.runButton)
        self.view.addSubview(self.resetButton)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([self.countTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.countTextField.heightAnchor.constraint(equalToConstant: 30),
            self.countTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.countTextField.widthAnchor.constraint(equalToConstant: 200)])
        
        NSLayoutConstraint.activate([self.runButton.topAnchor.constraint(equalTo: self.countTextField.topAnchor),
            self.runButton.heightAnchor.constraint(equalToConstant: 30),
            self.runButton.leadingAnchor.constraint(equalTo: self.countTextField.trailingAnchor, constant: 20),
            self.runButton.widthAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([self.progressView.topAnchor.constraint(equalTo: self.countTextField.bottomAnchor, constant: 20),
            self.progressView.heightAnchor.constraint(equalToConstant: 50),
            self.progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)])
        
        NSLayoutConstraint.activate([self.resetButton.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 20),
            self.resetButton.heightAnchor.constraint(equalToConstant: 30),
            self.resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.resetButton.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    func setTargets() {
        self.runButton.addTarget(self, action: #selector(runButton(_:)), for: .touchUpInside)
        self.resetButton.addTarget(self, action: #selector(resetButton(_:)), for: .touchUpInside)
    }
    
    @objc func runButton(_ sender: UIButton) {
        if let count = Int(self.countTextField.text!) {
            self.partitionObject.interval = count
            
            self.partitionObject.start()
            
        } else {
            print("Not number!!!!!!")
        }
    }
    
    @objc func resetButton(_ sender: UIButton) {
        self.countTextField.text = ""
        self.progressView.progress = 0.0
    }
}

extension ViewController: PartitionDelegate {
    func receive(currentValue: Float) {
        self.progressView.progress = currentValue
//        self.progressView.setProgress(currentValue, animated: true)
    }
}

