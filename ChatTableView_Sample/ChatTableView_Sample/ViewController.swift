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
    var tmpButton: UIButton!
    
    var chatTextFieldBottom: NSLayoutConstraint?
    var chatButtonBottom: NSLayoutConstraint?
    var tmpButtonBottom: NSLayoutConstraint?
    var chatTableTop: NSLayoutConstraint?
    
    var MAX: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createViews()
        self.setViews()
//        self.scrollToBottom()
        
        // Register keyboard event
        self.registerKeyboardEvent()
    }
    
    // *** 키보드 이동 후 스크롤 이동은 viewDidLayoutSubviews에 맞춘다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        self.scrollToBottom()
    }
    
    /// Create Views
    func createViews() {
        self.chatTable = createChatTable()
        self.view.addSubview(self.chatTable)
        
        self.chatTextField = createChatTextField()
        self.view.addSubview(self.chatTextField)
        
        self.tmpButton = UIButton()
        self.tmpButton.setTitle("-R-", for: .normal)
        self.tmpButton.setTitle("=r=", for: .highlighted)
        self.tmpButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.tmpButton.setTitleColor(.black, for: .normal)
        self.tmpButton.setTitleColor(.gray, for: .highlighted)
        self.tmpButton.addTarget(self, action: #selector(clickTmpButton(_:)), for: .touchUpInside)
        self.tmpButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tmpButton)
        
        self.chatButton = createChatButton()
        self.view.addSubview(self.chatButton)
    }
    
    //MARK: - Set Layout
    func setViews() {
        let safeGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        let marginGuide: UILayoutGuide = self.view.layoutMarginsGuide
        
        // Chat Table Layout
        self.chatTableTop = self.chatTable.topAnchor.constraint(equalTo: safeGuide.topAnchor)
        chatTableTop?.isActive = true
        self.chatTable.bottomAnchor.constraint(equalTo: self.chatTextField.topAnchor).isActive = true
        self.chatTable.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.chatTable.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        self.chatTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.chatTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        chatTextFieldBottom =  self.chatTextField.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        chatTextFieldBottom?.isActive = true
        self.chatTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.chatTextField.trailingAnchor.constraint(equalTo: self.tmpButton.leadingAnchor).isActive = true
        
        self.tmpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.tmpButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.tmpButton.topAnchor.constraint(equalTo: self.chatTable.bottomAnchor).isActive = true
        tmpButtonBottom = self.tmpButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        tmpButtonBottom?.isActive = true
        self.tmpButton.trailingAnchor.constraint(equalTo: self.chatButton.leadingAnchor).isActive = true
        
        
        self.chatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.chatButton.topAnchor.constraint(equalTo: self.chatTable.bottomAnchor).isActive = true
        chatButtonBottom = self.chatButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        chatButtonBottom?.isActive = true
        self.chatButton.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    // MARK: - Creation of objects
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
//        chatTable.separatorColor = UIColor.red
        chatTable.layer.borderWidth = 1
        chatTable.layer.borderColor = UIColor.gray.cgColor
        
        chatTable.translatesAutoresizingMaskIntoConstraints = false
        
        return chatTable
    }
    
    func createChatTextField() -> UITextField {
        let chatTextField: UITextField = UITextField()
        
        // No benifit for padding inside TextField
        // chatTextField.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        chatTextField.delegate = self
        chatTextField.layer.borderWidth = 1
        chatTextField.layer.borderColor = UIColor.black.cgColor
        chatTextField.layer.cornerRadius = 5
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
    
    // MARK: Scroll to bottom
    // keyboard
    func scrollToBottom() {
        let indexPath = IndexPath(row: self.MAX - 1, section: 1 - 1)
        self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func scrollToBottomAfterReload() {
        //        self.chatTable.reloadData() // TableView의 데이터 reload의 시점을 모르기 때문에 시점이 확실히 뒤인 같은 main.async에 넣는다.
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.MAX - 1, section: 1 - 1)
            self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            //        self.chatTable.scrollToNearestSelectedRow(at: .bottom, animated: true)
        }
    }
    
    func scrollToMiddle() {
        let selectedRows = self.chatTable.indexPathsForSelectedRows
        if let selectedRow = selectedRows?.first {
            self.chatTable.scrollToRow(at: selectedRow, at: .middle, animated: true)
        }
    }
}

// MARK: - Keyboard NotificationCenter
extension ViewController {
    func registerKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - A package of objc Functions
extension ViewController {
//    @objc func touchTextField(_ sender: UITextField) {
//        self.chatTextFieldBottom?.constant = -300
//        self.chatButtonBottom?.constant = -300
//    }
    
    @objc func clickButton(_ sender: UIButton) {
        self.chatTextFieldBottom?.constant = 0
        self.chatButtonBottom?.constant = 0
        self.tmpButtonBottom?.constant = 0
        self.chatTextField.resignFirstResponder()
//        self.scrollToBottom()
    }
    
    @objc func clickTmpButton(_ sender: UIButton) {
//        self.scrollToBottom()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            // MARK: - notification을 통해 얻는 keyboard animation duration
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            
            // 키보드를 통하지않고 safeAreaLayoutGuide를 통해서도 padding 부분을 구할 수 있을까? 밑에껀 일단 아님.
//            let bottomPadding: CGFloat? = self.view.safeAreaLayoutGuide.layoutFrame.size.height
            
            if self.chatTextFieldBottom?.constant == 0 {
                 // - view 높이와 safe Area 차이 만큼 빼기 (아이폰 X 이상부터 문제됨)
                self.chatTextFieldBottom?.constant -= (keyboardSize.height - (bottomPadding ?? 0))
                self.chatButtonBottom?.constant -= (keyboardSize.height - (bottomPadding ?? 0))
                self.tmpButtonBottom?.constant -= (keyboardSize.height - (bottomPadding ?? 0))
                
                UIView.animate(withDuration: duration) {
                    self.view.layoutIfNeeded()
                }
            }
            

            
            // 아래와 같은 코드는 view 자체를 올려서 접근 할 수 없는 문제가 있음
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            // MARK: - notification을 통해 얻는 keyboard animation duration
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            
            
            if self.chatTextFieldBottom?.constant != 0 {
                // - view 높이와 safe Area 차이 만큼 빼기 (아이폰 X 이상부터 문제됨)
                self.chatTextFieldBottom?.constant += keyboardSize.height + (bottomPadding ?? 0)
                self.chatButtonBottom?.constant += keyboardSize.height + (bottomPadding ?? 0)
                self.tmpButtonBottom?.constant += keyboardSize.height + (bottomPadding ?? 0)
            }
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
            
            // 아래와 같은 코드는 view 자체를 올려서 접근 할 수 없는 문제가 있음
//            if self.view.frame.origin.y != 0 {
//                self.view.frame.origin.y += keyboardSize.height
//            }
        }
    }
}

// MARK: - Table View Delegate and Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MAX
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
//        self.scrollToBottom()
        
        return true
    }
}

