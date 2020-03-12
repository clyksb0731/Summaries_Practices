//
//  NextViewController.swift
//  ViewSlideSample
//
//  Created by Yongseok Choi on 2020/03/12.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var nextVCButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Next VC", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
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
extension NextViewController {
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
extension NextViewController {
    // MARK: Set view foundation
    func setViewFoundation() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        .font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        self.navigationItem.title = "Next View"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "⬅️", style: .plain, target: self, action: #selector(leftBarButton(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    // MARK: Set targets
    func setTargets() {
        self.previousVCButton.addTarget(self, action: #selector(previousVCButton(_:)), for: .touchUpInside)
        self.nextVCButton.addTarget(self, action: #selector(nextVCButton(_:)), for: .touchUpInside)
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.view.addSubview(self.centerView)
        self.view.addSubview(self.buttonsView)
        self.buttonsView.addSubview(self.previousVCButton)
        self.buttonsView.addSubview(self.nextVCButton)
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // Center view layout
        NSLayoutConstraint.activate([
            self.centerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.centerView.heightAnchor.constraint(equalToConstant: 200),
            self.centerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.centerView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
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
    }
}

// MARK: Extension for objc methods added
extension NextViewController {
    @objc func leftBarButton(_ sender: UIBarButtonItem) {
        if let previousVC = self.navigationController?.viewControllers[0] as? CoverViewController {
            switch previousVC.viewAppearance {
            case .hide:
                self.dismiss(animated: false, completion: nil)
                
            case .show:
                self.navigationController?.popViewController(animated: false)
            }
            
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func previousVCButton(_ sender: UIButton) {
        if let previousVC = self.navigationController?.viewControllers[0] as? CoverViewController {
            switch previousVC.viewAppearance {
            case .hide:
                self.dismiss(animated: false, completion: nil)
                
            case .show:
                self.navigationController?.popViewController(animated: false)
            }
            
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func nextVCButton(_ sender: UIButton) {
        
    }
}
