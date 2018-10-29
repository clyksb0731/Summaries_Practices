//
//  LogInViewController.swift
//  TableViewSummary
//
//  Created by 최용석 on 29/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private var basicView: UIView?
    private var dismissImgBtnView: UIView?
    private var titleLabel: UILabel?
    private var upperDesLabel: UILabel?
    private var logInFailureNoti: UILabel?
    private var emailTextField: UITextField?
    private var pwTextField: UITextField?
    private var logInButton: UIButton?
    private var lowerDesLabel: UILabel?
    
    private var isStausBarHidden: Bool = false  // to set status bar on
    
    // Preparation for user email transmission from SignUp view controller
    var loginEmail: String? {
        didSet {
            guard let emailTextField = emailTextField else { return }
            emailTextField.text = loginEmail
        }
    }
    
    private var safeGuide: UILayoutGuide?
    private var textFieldPositionConstraint: NSLayoutConstraint?
    private let movingHeight: CGFloat = 130 // distance to be moved at keyboard-up
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        createItems() // create all components
        addSubviews() // add all components onto root view
        setLayout() // set auto layout
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override var prefersStatusBarHidden: Bool {
        if isStausBarHidden {
            return true
        } else {
            return false
        }
    }
    
    deinit {
        print("LogIn VC is disposed")
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        guard let basicView = basicView,
            let logInFailureNoti = logInFailureNoti,
            let dismissImgBtnView = dismissImgBtnView,
            let titleLabel = self.titleLabel,
            let upperDesLabel = self.upperDesLabel,
            let emailTextField = self.emailTextField,
            let pwTextField = self.pwTextField,
            let logInButton = self.logInButton,
            let lowerDesLabel = self.lowerDesLabel
            else { return }
        
        self.view.addSubview(basicView)
        self.view.addSubview(logInFailureNoti)
        self.view.addSubview(dismissImgBtnView)  // MARK: subViews were already laid out inside
        self.view.addSubview(titleLabel)
        self.view.addSubview(upperDesLabel)
        basicView.addSubview(emailTextField)
        basicView.addSubview(pwTextField)
        basicView.addSubview(logInButton)
        basicView.addSubview(lowerDesLabel)
    }
    
    // MARK: - Create All Components
    /// Create all components on this view controller
    private func createItems() {
        setBasicView()
        setLogInFailureNoti()
        setDismissImgBtnView()
        setTitleLabel()
        setUpperDesLabel()
        setEmailTextField()
        setPWTextField()
        setLogInButton()
        setLowerDesLabel()
    }
    
    private func setBasicView() {
        basicView = UIView()
        basicView!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLogInFailureNoti() {
        logInFailureNoti = UILabel()
        logInFailureNoti!.text = "네트워크 확인이 필요합니다."
        logInFailureNoti!.textColor = .white
        logInFailureNoti!.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        logInFailureNoti!.backgroundColor = .gray
        logInFailureNoti!.alpha = 0.5
        logInFailureNoti!.layer.cornerRadius = 10
        logInFailureNoti!.clipsToBounds = true
        logInFailureNoti!.textAlignment = .center
        logInFailureNoti!.isHidden = true
        logInFailureNoti!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDismissImgBtnView() {
        dismissImgBtnView = UIView()
        dismissImgBtnView!.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissImageView = UIImageView(image: UIImage(named: "dismiss"))
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        dismissImgBtnView!.addSubview(dismissImageView)
        dismissImgBtnView!.addSubview(dismissButton)
        
        // layout items on dismissImgBtnView
        // dismissImageView
        dismissImageView.topAnchor.constraint(equalTo: dismissImgBtnView!.topAnchor).isActive = true
        dismissImageView.bottomAnchor.constraint(equalTo: dismissImgBtnView!.bottomAnchor).isActive = true
        dismissImageView.leadingAnchor.constraint(equalTo: dismissImgBtnView!.leadingAnchor).isActive = true
        dismissImageView.trailingAnchor.constraint(equalTo: dismissImgBtnView!.trailingAnchor).isActive = true
        
        // dismissButton
        dismissButton.topAnchor.constraint(equalTo: dismissImgBtnView!.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: dismissImgBtnView!.bottomAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: dismissImgBtnView!.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissImgBtnView!.trailingAnchor).isActive = true
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel!.text = "LOG IN"
        titleLabel!.textAlignment = .center
        titleLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        titleLabel!.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        titleLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpperDesLabel() {
        upperDesLabel = UILabel()
        upperDesLabel!.text = "Good to see you again"
        upperDesLabel!.textAlignment = .center
        upperDesLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        upperDesLabel!.font = UIFont.systemFont(ofSize: 14)
        upperDesLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setEmailTextField() {
        emailTextField = UITextField()
        emailTextField!.delegate = self
        emailTextField!.tag = 1
        emailTextField!.placeholder = "Your Email"
        emailTextField!.keyboardType = .emailAddress
        emailTextField!.returnKeyType = .next
        emailTextField!.spellCheckingType = .no
        emailTextField!.autocorrectionType = .no
        emailTextField!.autocapitalizationType = .none
        emailTextField!.textContentType = UITextContentType(rawValue: "")
        emailTextField!.textAlignment = .left
        emailTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        emailTextField!.font = UIFont.systemFont(ofSize: 14)
        emailTextField!.layer.borderWidth = 1
        emailTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        emailTextField!.layer.cornerRadius = 5
        emailTextField!.clipsToBounds = true
        emailTextField!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setPWTextField() {
        pwTextField = UITextField()
        pwTextField!.isSecureTextEntry = true
        pwTextField!.delegate = self
        pwTextField!.tag = 2
        pwTextField!.placeholder = "Password"
        pwTextField!.returnKeyType = .continue
        pwTextField!.textAlignment = .left
        pwTextField!.textContentType = UITextContentType(rawValue: "")
        pwTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        pwTextField!.font = UIFont.systemFont(ofSize: 14)
        pwTextField!.layer.cornerRadius = 5
        pwTextField!.clipsToBounds = true
        pwTextField!.layer.borderWidth = 1
        pwTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        
        pwTextField!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLogInButton() {
        logInButton = UIButton()
        logInButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        logInButton!.setTitleColor(UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.3), for: .highlighted)
        logInButton!.setTitle("LOG IN", for: .normal)
        logInButton!.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        logInButton!.setTitleColor(.white, for: .normal)
        logInButton!.layer.cornerRadius = 10
        logInButton!.clipsToBounds = true
        logInButton!.addTarget(self, action: #selector(tmpDismiss(_:)), for: .touchUpInside)
        logInButton!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLowerDesLabel() {
        lowerDesLabel = UILabel()
        lowerDesLabel!.text = "Forgot your password?"
        lowerDesLabel!.textAlignment = .center
        lowerDesLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        lowerDesLabel!.font = UIFont.systemFont(ofSize: 14)
        lowerDesLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Set Layout
    /// Set layout components
    private func setLayout() {
        guard let basicView = basicView,
            let logInFailureNoti = logInFailureNoti,
            let dismissImgBtnView = dismissImgBtnView,
            let titleLabel = self.titleLabel,
            let upperDesLabel = self.upperDesLabel,
            let emailTextField = self.emailTextField,
            let pwTextField = self.pwTextField,
            let logInButton = self.logInButton,
            let lowerDesLabel = self.lowerDesLabel
            else { return }
        
        safeGuide = self.view.safeAreaLayoutGuide
        
        // Basic View
        //        basicView.heightAnchor.constraint(equalTo: safeGuide!.heightAnchor).isActive = true
        basicView.widthAnchor.constraint(equalTo: safeGuide!.widthAnchor).isActive = true
        
        //        textFieldPositionConstraint = basicView.centerYAnchor.constraint(equalTo: safeGuide!.centerYAnchor)
        //        textFieldPositionConstraint!.isActive = true
        
        basicView.centerXAnchor.constraint(equalTo: safeGuide!.centerXAnchor).isActive = true
        basicView.topAnchor.constraint(equalTo: upperDesLabel.bottomAnchor).isActive = true
        
        textFieldPositionConstraint = basicView.bottomAnchor.constraint(equalTo: safeGuide!.bottomAnchor)
        textFieldPositionConstraint?.isActive = true
        
        // LogIn Failure Notification Label
        logInFailureNoti.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logInFailureNoti.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logInFailureNoti.centerXAnchor.constraint(equalTo: safeGuide!.centerXAnchor).isActive = true
        logInFailureNoti.topAnchor.constraint(equalTo: safeGuide!.topAnchor, constant: 156).isActive = true
        
        // Dismiss Image-Button View
        dismissImgBtnView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dismissImgBtnView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        dismissImgBtnView.topAnchor.constraint(equalTo: safeGuide!.topAnchor, constant: 16).isActive = true
        dismissImgBtnView.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor, constant: 15).isActive = true
        
        // Title Label
        titleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeGuide!.topAnchor, constant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor, constant: 32).isActive = true
        safeGuide!.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 31).isActive = true
        
        // Uppder Description Label
        upperDesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        upperDesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        upperDesLabel.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor, constant: 32).isActive = true
        safeGuide!.trailingAnchor.constraint(equalTo: upperDesLabel.trailingAnchor, constant: 31).isActive = true
        
        // Email TextField
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 24).isActive = true
        
        // Password TextField
        pwTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logInButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 24).isActive = true
        pwTextField.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor, constant: 24).isActive = true
        
        // Log In Button
        logInButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lowerDesLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 24).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: 24).isActive = true
        
        // Lower Description Label
        lowerDesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        basicView.bottomAnchor.constraint(equalTo: lowerDesLabel.bottomAnchor, constant: 99).isActive = true
        lowerDesLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 16).isActive = true
        basicView.trailingAnchor.constraint(equalTo: lowerDesLabel.trailingAnchor, constant: 15).isActive = true
    }
}

// MARK: TextField Delegate
extension LogInViewController: UITextFieldDelegate {
    
}

// MARK: objc Functions
extension LogInViewController {
    @objc func tmpDismiss(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


