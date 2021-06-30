//
//  NextViewController.swift
//  NavigationBarTest
//
//  Created by Yongseok Choi on 2021/06/30.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewFonundation()
    }
}

// MARK: - Extension for methods added
extension NextViewController {
    func setViewFonundation() {
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "네비바 테스트"
        self.navigationController?.navigationBar.tintColor = .green
        
        let firstBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(firstBarButtonItem(_:)))
        firstBarButtonItem.tintColor = .black
        
        let secondBarButtonItem = UIBarButtonItem(customView: {
            let label = UILabel()
            label.text = "LeftLabel"
            label.font = UIFont.systemFont(ofSize: 30)
            label.textColor = .blue
            
            return label
        }());
        secondBarButtonItem.tintColor = .red
        
        // LeftBarButtonItem이 앞의 view controller보다 우선적으로 표시된다.
        self.navigationItem.leftBarButtonItems = [firstBarButtonItem, secondBarButtonItem]
        
        /*
        // This code must be on the previous view controller not here.
        let backBarButtonItem =  UIBarButtonItem(title: "BackBarButton", style: .plain, target: self, action: #selector(firstBarButtonItem(_:)))
        backBarButtonItem.tintColor = .red
        self.navigationItem.backBarButtonItem = backBarButtonItem
         */
    }
}

// MARK: Extension for selector methods
extension NextViewController {
    @objc func firstBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
}
