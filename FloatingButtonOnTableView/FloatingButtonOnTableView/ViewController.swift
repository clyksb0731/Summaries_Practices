//
//  ViewController.swift
//  FloatingButtonOnTableView
//
//  Created by Yongseok Choi on 2021/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.makeTableView()
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.button)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: -20),
            self.button.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -20)
        ])
    }

    func makeTableView() {
        self.tableView = UITableView()
        //self.tableView.bounces = false
        self.tableView.register(TempCell.self, forCellReuseIdentifier: "TempCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempCell", for: indexPath) as! TempCell
        cell.label.text = "\(indexPath.row)"
        
//        if (indexPath.row == 29) {
//            self.button.isHidden = true
//
//        } else {
//            self.button.isHidden = false
//        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (indexPath.row == 29) {
//            self.button.isHidden = true
//
//        } else {
//            self.button.isHidden = false
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 29, section: 0)) {
//            if self.tableView.visibleCells.contains(cell) {
//                self.button.isHidden = true
//            } else {
//                self.button.isHidden = false
//            }
            
            self.button.isHidden = true
            
        } else {
            self.button.isHidden = false
        }
    }
    
}
