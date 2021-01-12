//
//  ViewController.swift
//  TableViewMovableCell
//
//  Created by Yongseok Choi on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    
    var array: Array<String> = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeViews()
        self.setSubviews()
        self.setLayouts()
    }

    func initializeViews() {
        self.tableView = {
            let tableView = UITableView()
            tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
            tableView.backgroundColor = .white
            tableView.bounces = false
            tableView.delegate = self
            tableView.dataSource = self
            //tableView.isEditing = true
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            return tableView
        }()
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(makeTableViewEditiable(_:)))
        longPressGesture.minimumPressDuration = 1
//        longPressGesture.numberOfTapsRequired = 1
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    func setSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    @objc func makeTableViewEditiable(_ recognizer: UILongPressGestureRecognizer) {
        print("isEditing: \(self.tableView.isEditing)")
        print("Recognizer State: \(recognizer.state.rawValue)")
        
        if recognizer.state == .began {
            self.tableView.isEditing = !self.tableView.isEditing
            
            if !isEditing {
                self.tableView.reloadData()
            }
        }
        
        if recognizer.state == .ended {
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = array[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("from:\(sourceIndexPath.row) to:\(destinationIndexPath.row)")
        print("Previous Array: \(self.array)")
        
        let text = self.array[sourceIndexPath.row]
        self.array.remove(at: sourceIndexPath.row)
        self.array.insert(text, at: destinationIndexPath.row)
        
        print("Array updated: \(self.array)")
    }
    
    // Hide delete button
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // Hide delete button space
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

