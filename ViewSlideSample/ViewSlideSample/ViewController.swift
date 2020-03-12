//
//  ViewController.swift
//  ViewSlideSample
//
//  Created by Yongseok Choi on 2020/03/12.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonsView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var previousVCButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("Previous VC", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var nextVCButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Next VC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var movableViewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTargets()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewFoundation()
    }
    
    deinit {
        print("----------------------------------- ViewController disposed -----------------------------------")
    }
}

// MARK: Extension for overrided methods
extension ViewController {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}

// MARK: Extension for Methods added
extension ViewController {
    // MARK: Set view foundation
    func setViewFoundation() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        .font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        self.navigationItem.title = "Main VC"
    }
    
    // MARK: Set targets
    func setTargets() {
        self.previousVCButton.addTarget(self, action: #selector(previousVCButton(_:)), for: .touchUpInside)
        self.nextVCButton.addTarget(self, action: #selector(nextVCButton(_:)), for: .touchUpInside)
        self.movableViewButton.addTarget(self, action: #selector(movableViewButton(_:)), for: .touchUpInside)
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.view.addSubview(self.buttonsView)
        self.view.addSubview(self.movableViewButton)
        self.buttonsView.addSubview(self.previousVCButton)
        self.buttonsView.addSubview(self.nextVCButton)
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // Buttons view layout
        NSLayoutConstraint.activate([
            self.buttonsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.buttonsView.heightAnchor.constraint(equalToConstant: 150),
            self.buttonsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.buttonsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        // Previous VC button layout
        NSLayoutConstraint.activate([
            self.previousVCButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
            self.previousVCButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
            self.previousVCButton.leadingAnchor.constraint(equalTo: self.buttonsView.leadingAnchor),
            self.previousVCButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/2)
        ])
        
        // Cover VC button layout
        NSLayoutConstraint.activate([
            self.nextVCButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
            self.nextVCButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
            self.nextVCButton.leadingAnchor.constraint(equalTo: self.previousVCButton.trailingAnchor),
            self.nextVCButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/2)
        ])
        
        // Movable view button layout
        NSLayoutConstraint.activate([
            self.movableViewButton.bottomAnchor.constraint(equalTo: self.buttonsView.topAnchor, constant: -20),
            self.movableViewButton.heightAnchor.constraint(equalToConstant: 50),
            self.movableViewButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.movableViewButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

// MARK: Extension for objc methods added
extension ViewController {
    @objc func previousVCButton(_ sender: UIButton) {
        
    }
    
    @objc func nextVCButton(_ sender: UIButton) {
        let nextVC = NextViewController()
        let naviVC = UINavigationController(rootViewController: nextVC)
        naviVC.modalPresentationStyle = .overFullScreen
        
        self.present(naviVC, animated: false, completion: nil)
    }
    
    @objc func movableViewButton(_ sender: UIButton) {
        let coverVC = CoverViewController()
        let naviVC = UINavigationController(rootViewController: coverVC)
        naviVC.modalPresentationStyle = .overFullScreen
        
        self.present(naviVC, animated: false, completion: nil)
    }
}


