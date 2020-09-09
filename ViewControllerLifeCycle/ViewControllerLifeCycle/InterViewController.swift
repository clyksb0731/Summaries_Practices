//
//  InterViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Yongseok Choi on 2020/09/04.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class InterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToTabVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstVC = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        
        let tabBarVC = TabBarViewController()
        tabBarVC.viewControllers = [firstVC, secondVC]
        tabBarVC.modalPresentationStyle = .fullScreen

        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
}
