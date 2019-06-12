//
//  ViewController.swift
//  TableView_Selection
//
//  Created by Yongseok Choi on 12/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selectionTable: UITableView!
    
    var headers: [String] = [
        "teaching you how to get started with Sketch (and some of the great complementary tools I use alongside it).",
        "teaching you how to get started with Sketch",
        "abcdefghijklmn"
    ]
    
    var cells: [[String]] = [
        [
            """
            In this first part I’ll be showing
            you how to work your way around the application,
            and some tips, plugins, and resources
            I use when creating a design like this in Sketch.
            """
        ],
        [
            """
            In this first part I’ll be showing
            you how to work your way around the application,
            and some tips, plugins, and resources
            I use when creating a design like this in Sketch.
            """
        ],
        [
            """
            In this first part I’ll be showing
            you how to work your way around the application,
            and some tips, plugins, and resources
            I use when creating a design like this in Sketch.
            """
        ]
    ]
    
    var tmpCells: [[String]] = []
    
    var selectedHeaders: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.instantiateObjects()
        self.setDelegates()
        self.setSubviews()
        self.setLayout()
        
    }
}

// MARK: Extension for methods added
extension ViewController {
    // MARK: Instantiate objects
    func instantiateObjects() {
        self.selectionTable = {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.separatorStyle = .none
            tableView.register(SelectionHeader.self, forHeaderFooterViewReuseIdentifier: "selectionHeader")
            tableView.register(SubCell.self, forCellReuseIdentifier: "subCell")
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.estimatedSectionHeaderHeight = 50
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.backgroundColor = .white
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            return tableView
        }()
        
        for _ in self.cells {
            self.tmpCells.append([])
        }
    }
    
    // MARK: Set delegates
    func setDelegates() {
        self.selectionTable.delegate = self
        self.selectionTable.dataSource = self
    }
    
    // MARK: Set targets
    func setTargets() {
        
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.view.addSubview(self.selectionTable)
    }
    
    // MARK: Set layouts
    func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.selectionTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.selectionTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.selectionTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.selectionTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
}

// MARK: Extension for objc methods added
extension ViewController {
    @objc func headerButton(_ sender: UIButton) {
        if self.selectedHeaders.contains(sender.tag) {
            self.selectedHeaders.remove(sender.tag)
            
//            self.selectionTable.beginUpdates()
//            self.tmpCells[sender.tag] = []
//            self.selectionTable.reloadSections([sender.tag], with: .automatic)
//            self.selectionTable.endUpdates()
            
            self.tmpCells[sender.tag] = []
            self.selectionTable.reloadData()
            
            
        } else {
//            self.selectionTable.beginUpdates()
//            self.tmpCells[sender.tag] = cells[sender.tag]
//            self.selectionTable.reloadSections([sender.tag], with: .automatic)
//            self.selectionTable.endUpdates()
            
            self.tmpCells[sender.tag] = cells[sender.tag]
            self.selectionTable.reloadData()
            
            
            self.selectedHeaders.insert(sender.tag)
        }
    }
}

// MARK: Extension for UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmpCells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath) as! SubCell
        if self.tmpCells[indexPath.section].count > 0 {
            cell.setCell(content: self.tmpCells[indexPath.section].first!)
            cell.backgroundColor = .gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "selectionHeader") as! SelectionHeader
        headerView.setHeader(title: self.headers[section], tag: section)
        headerView.headerButton.addTarget(self, action: #selector(headerButton(_:)), for: .touchUpInside)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    
}

