//
//  NextViewController.swift
//  TableViewSample
//
//  Created by 최용석 on 29/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var aTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .clear
        tableView.register(AutosizingCell.self, forCellReuseIdentifier: "autosizingCell")
        tableView.register(AnotherCell.self, forCellReuseIdentifier: "anotherCell")
        
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
        "기존 버전관리 시스템과 같이 중앙 저장소를 통해 협업 가능 사용자는 변경된 내용을 개인 저장소에 저장(commit) 개인 저장소에 있는 변경된 내용을 중앙 저장소에 저장(Pushing)",
        "기존 버전관리 시스템과 같이 중앙 저장소를 통해 협업 가능 사용자는 변경된 내용을 개인 저장소에 저장(commit)",
        "adlklajglkajkgjakjgkjgljajdlgjalkjglkajglajdlgjaldjglajlgjalkdgjakljgalkjdgljdgljdlgjlgjalsgjj"
    ]
    
    let secondTexts: [String] = [
        "기존",
        "기존",
        "adlkl"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aTableView.rowHeight = UITableView.automaticDimension
        self.aTableView.estimatedRowHeight = 150
        
        self.setDelegates()
        self.setSubviews()
        self.setLayouts()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewFoundation()
    }
    
    
}

// MARK: Extension for methods added
extension NextViewController {
    func setViewFoundation() {
        self.view.backgroundColor = .white
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
        self.aTableView.delegate = self
        self.aTableView.dataSource = self
    }
    
    /**
     */
    func setNotificationCenters() {
        
    }
    
    /**
     */
    func setSubviews() {
        self.view.addSubview(self.aTableView)
    }
    
    /**
     */
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.aTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.aTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.aTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.aTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
}

// MARK: Extension for UITableViewDelegate and UITableViewDataSource
extension NextViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.cells.count
        return self.texts.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autosizingCell", for: indexPath) as! AutosizingCell
        
        //        cell.label.text = self.texts[indexPath.row]
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.label.text = self.texts[indexPath.row]
        
        return cell
    }
    //
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "1"
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 10
    //    }
    //
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return "2"
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 10
    //    }
}
