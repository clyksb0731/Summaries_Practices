//
//  ViewController.swift
//  NavigationBarTest
//
//  Created by Yongseok Choi on 2021/06/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Root VC"
        
        // MARK: Setting back button
        // This code must be here before pushing.
        let backBarButtonItem =  UIBarButtonItem(title: "BackBarButton", style: .plain, target: self, action: #selector(backBarButtonItem(_:)))
        backBarButtonItem.tintColor = .red
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @IBAction func nextVC(_ sender: UIButton) {
        let nextVC = NextViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func backBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
}



