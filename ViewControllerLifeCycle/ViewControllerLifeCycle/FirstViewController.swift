//
//  FirstViewController.swift
//  ViewControllerLifeCycle
//
//  Created by Yongseok Choi on 2020/09/04.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func presentPresentedVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let presentedVC = storyboard.instantiateViewController(withIdentifier: "PresentedViewController")
        presentedVC.modalPresentationStyle = .fullScreen

        self.present(presentedVC, animated: true, completion: nil)
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        
        rootVC?.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
}
