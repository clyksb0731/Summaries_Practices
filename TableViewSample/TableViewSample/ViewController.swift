//
//  ViewController.swift
//  TableViewSample
//
//  Created by 최용석 on 28/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(AutosizingCell.self, forCellReuseIdentifier: "autosizingCell")
        tableView.register(AnotherCell.self, forCellReuseIdentifier: "anotherCell")
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    enum CellType {
        case autosizing
        case another
    }
    
    let cells: [CellType] = [
        .autosizing,
        .another,
        .autosizing,
        .another,
        .another,
        .autosizing
    ]
    
    let texts: [String] = [
        """
        기존 버전관리 시스템과 같이 중앙 저장소를 통해 협업 가능
        사용자는 변경된 내용을 개인 저장소에 저장(commit)
        개인 저장소에 있는 변경된 내용을 중앙 저장소에 저장(Pushing)
        """,
        """
        기존 버전관리 시스템과 같이 중앙 저장소를 통해 협업 가능
        사용자는 변경된 내용을 개인 저장소에 저장(commit)
        """,
        """
        adlklajglkajkgjakjgkjgljajdlgjalkjglkajglajdlgjaldjglajlgjalkdgjakljgalkjdgljdgljdlgjlgjalsgjj
        """
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegates()
        self.setSubviews()
        self.setLayouts()
    }


}

// MARK: Extension for methods added
extension ViewController {
    func setViewFoundation() {
        
    }
    
    /**
     */
    func setTargets() {
        
    }
    
    /**
     */
    func setGestures() {
        
    }
    
    /**
     */
    func setDelegates() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    /**
     */
    func setNotificationCenters() {
        
    }
    
    /**
     */
    func setSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    /**
     */
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
}

// MARK: Extension for UITableViewDelegate and UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cells.count
        return self.texts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autosizingCell", for: indexPath) as! AutosizingCell
        
        cell.label.text = self.texts[indexPath.row]
        
        return cell
    }
}

