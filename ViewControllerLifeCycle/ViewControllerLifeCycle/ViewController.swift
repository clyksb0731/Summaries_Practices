//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Yongseok Choi on 2020/09/04.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let interVC = storyboard.instantiateViewController(withIdentifier: "InterViewController")
        self.navigationController?.pushViewController(interVC, animated: true)
    }
    

    @IBAction func goToTabVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstVC = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        
        let tabBarVC = TabBarViewController()
        tabBarVC.viewControllers = [firstVC, secondVC]
        tabBarVC.modalPresentationStyle = .fullScreen

        self.present(tabBarVC, animated: true, completion: nil)
        
//        self.navigationController?.pushViewController(tabBarVC, animated: false)
    }
    
}

