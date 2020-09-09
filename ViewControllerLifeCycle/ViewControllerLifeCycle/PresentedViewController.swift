//
//  PresentedViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Yongseok Choi on 2020/09/04.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSecondVC(_ sender: Any) {
        if let tabBarVC = self.presentingViewController as? TabBarViewController {
            tabBarVC.selectedIndex = 1
        }
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        
        rootVC?.dismiss(animated: true, completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
    }
}
