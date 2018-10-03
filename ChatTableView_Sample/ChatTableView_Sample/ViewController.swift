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
    var chatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Create Views
    func createViews() {
        self.chatTable = UITableView()
        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        
        self.chatButton = UIButton()
    }
    
    /// Set Layout
    func setViews() {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

