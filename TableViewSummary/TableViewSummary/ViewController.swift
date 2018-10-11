//
//  ViewController.swift
//  TableViewSummary
//
//  Created by 최용석 on 11/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!
    var vcContainer: Dictionary<String, UIViewController>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // createTmpObj()
        
//        label.fadeIn(completion: {
//            (Bool) -> Void in
//            self.label.fadeOut()
//        })
    }
    
    func createAndInsert(_ vc: UIViewController, named name: String) {
        self.vcContainer.updateValue(vc, forKey: name)
    }
    
    // MARK: Temporary View to show with fade in and out
    func createTmpObj() {
        let safeGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        label = UILabel()
        label.text = "임시로"
        label.backgroundColor = .green
        label.alpha = 0.0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor).isActive = true
    }
    
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 3.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 2.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
