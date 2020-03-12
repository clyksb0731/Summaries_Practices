//
//  CoverViewController.swift
//  ViewSlideSample
//
//  Created by Yongseok Choi on 2020/03/12.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class CoverViewController: UIViewController {
    
    enum MoveType {
        case show
        case hide
    }
    
    var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.1
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var movableView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
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
    
    var movableViewTopAnchorConstraint: NSLayoutConstraint!
    var viewAppearance: MoveType = .hide
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.controlMovableView(.show)
    }
    
    deinit {
        print("----------------------------------- CoverViewController disposed -----------------------------------")
    }
}

// MARK: Extension for overrided methods
extension CoverViewController {
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
extension CoverViewController {
    // MARK: Set view foundation
    func setViewFoundation() {
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Set targets
    func setTargets() {
        self.previousVCButton.addTarget(self, action: #selector(previousVCButton(_:)), for: .touchUpInside)
        self.nextVCButton.addTarget(self, action: #selector(nextVCButton(_:)), for: .touchUpInside)
        self.movableViewButton.addTarget(self, action: #selector(movableViewButton(_:)), for: .touchUpInside)
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.view.addSubview(self.baseView)
        self.view.addSubview(self.movableView)
        self.view.addSubview(self.buttonsView)
        self.view.addSubview(self.movableViewButton)
        self.buttonsView.addSubview(self.previousVCButton)
        self.buttonsView.addSubview(self.nextVCButton)
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // Base view layout
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.buttonsView.topAnchor),
            self.baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Movable view layout
        self.movableViewTopAnchorConstraint = self.movableView.topAnchor.constraint(equalTo: self.buttonsView.topAnchor)
        NSLayoutConstraint.activate([
            self.movableViewTopAnchorConstraint,
            self.movableView.heightAnchor.constraint(equalToConstant: 500),
            self.movableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.movableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.7)
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
        
        // Movable view button layout
        NSLayoutConstraint.activate([
            self.movableViewButton.bottomAnchor.constraint(equalTo: self.buttonsView.topAnchor, constant: -20),
            self.movableViewButton.heightAnchor.constraint(equalToConstant: 50),
            self.movableViewButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.movableViewButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func controlMovableView(_ appearance: MoveType) {
        switch appearance {
        case .show:
            self.movableViewTopAnchorConstraint.constant = -500
            self.baseView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.baseView.alpha = 0.3
                
            }) { (success) in
                if success {
                    self.movableViewButton.setTitle("Hide", for: .normal)
                }
            }
            
        case .hide:
            self.movableViewTopAnchorConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.baseView.alpha = 0.1
                
            }) { (success) in
                if success {
                    self.baseView.isHidden = true
                    self.movableViewButton.setTitle("Show", for: .normal)
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        
        self.viewAppearance = appearance
    }
}

// MARK: Extension for objc methods added
extension CoverViewController {
    @objc func previousVCButton(_ sender: UIButton) {
        
    }
    
    @objc func nextVCButton(_ sender: UIButton) {
        let nextVC = NextViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func movableViewButton(_ sender: UIButton) {
        self.controlMovableView(.hide)
    }
}
