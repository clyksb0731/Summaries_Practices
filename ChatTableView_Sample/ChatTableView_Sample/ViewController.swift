//
//  ViewController.swift
//  ChatTableView_Sample
//
//  Created by 최용석 on 03/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var chatTable: UITableView!
    var chatTextField: UITextField!
    var chatButton: UIButton!
    
    var chatTextFieldBottom: NSLayoutConstraint?
    var chatButtonBottom: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createViews()
        self.setViews()
        self.registerKeyboardEvent()
    }
    
    /// Create Views
    func createViews() {
        self.chatTable = createChatTable()
        self.view.addSubview(self.chatTable)
        
        self.chatTextField = createChatTextField()
        self.view.addSubview(self.chatTextField)
        
        self.chatButton = createChatButton()
        self.view.addSubview(self.chatButton)
    }
    
    /// Set Layout
    func setViews() {
        let safeGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        let marginGuide: UILayoutGuide = self.view.layoutMarginsGuide
        
        // Chat Table Layout
        self.chatTable.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        self.chatTable.bottomAnchor.constraint(equalTo: self.chatTextField.topAnchor).isActive = true
        self.chatTable.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.chatTable.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        self.chatTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.chatTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        chatTextFieldBottom =  self.chatTextField.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        chatTextFieldBottom?.isActive = true
        self.chatTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.chatTextField.trailingAnchor.constraint(equalTo: self.chatButton.leadingAnchor).isActive = true
        
        self.chatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.chatButton.topAnchor.constraint(equalTo: self.chatTable.bottomAnchor).isActive = true
        chatButtonBottom = self.chatButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        chatButtonBottom?.isActive = true
        self.chatButton.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    func createChatTable() -> UITableView {
        let chatTable: UITableView = UITableView()
        chatTable.delegate = self
        chatTable.dataSource = self
        
        // For programmatically created cell
        chatTable.register(ChatCell.self, forCellReuseIdentifier: "MyCell")
        chatTable.register(AnotherChatCell.self, forCellReuseIdentifier: "YourCell")
        
        // For xib file load to use cell
//        chatTable.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        chatTable.separatorStyle = .none
        chatTable.separatorColor = UIColor.red
        chatTable.layer.borderWidth = 1
        chatTable.layer.borderColor = UIColor.gray.cgColor
        
        chatTable.translatesAutoresizingMaskIntoConstraints = false
        
        return chatTable
    }
    
    func createChatTextField() -> UITextField {
        let chatTextField: UITextField = UITextField()
        chatTextField.delegate = self
        chatTextField.layer.borderWidth = 1
        chatTextField.layer.borderColor = UIColor.black.cgColor
        chatTextField.layer.cornerRadius = 10
        chatTextField.clipsToBounds = true
        
        // TODO: - Why not touchUpInside? -> NotificationCenter!!
//        chatTextField.addTarget(self, action: #selector(touchTextField(_:)), for: .touchUpInside)
        
        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return chatTextField
    }
    
    func createChatButton() -> UIButton {
        let chatButton: UIButton = UIButton()
        chatButton.setTitle("Send", for: .normal)
        chatButton.setTitle("Clicked", for: .highlighted)
        chatButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        chatButton.setTitleColor(UIColor.black, for: .normal)
        chatButton.setTitleColor(UIColor.gray, for: .highlighted)
        chatButton.backgroundColor = .yellow
        chatButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
        return chatButton
    }
}

// MARK: - Keyboard NotificationCenter
extension ViewController {
    func registerKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                print("keyboard show")
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
                print("keyboard hide")
            }
        }
    }
}

// MARK: - A package of objc Functions
extension ViewController {
    @objc func touchTextField(_ sender: UITextField) {
        self.chatTextFieldBottom?.constant = -300
        self.chatButtonBottom?.constant = -300
    }
    
    @objc func clickButton(_ sender: UIButton) {
        self.chatTextFieldBottom?.constant = 0
        self.chatButtonBottom?.constant = 0
        self.chatTextField.resignFirstResponder()
    }
}

// MARK: - Table View Delegate and Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // A reuse sample for two cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ChatCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "YourCell", for: indexPath) as! AnotherChatCell
        }
        
        return cell
    }
    
}

// MARK: - TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.chatTextFieldBottom?.constant = 0
        self.chatButtonBottom?.constant = 0
        
        return true
    }
}

