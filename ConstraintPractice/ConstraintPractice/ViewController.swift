//
//  ViewController.swift
//  ConstraintPractice
//
//  Created by Yongseok Choi on 2020/09/09.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var testButton: UIButton!
    //@IBOutlet var yellowViewBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var yellowViewBottomAnchor: NSLayoutConstraint!
    // weak var blueViewBottomAnchor: NSLayoutConstraint! // MARK: Same case as weak IBOutlet reference
    var blueViewBottomAnchor: NSLayoutConstraint! // Different from the weak IBOutlet for reference
    weak var tempView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(blueView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.blueViewBottomAnchor = blueView.bottomAnchor.constraint(equalTo: self.testButton.topAnchor, constant: -50)
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: self.yellowView.bottomAnchor, constant: 50),
            self.blueViewBottomAnchor,
            blueView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            blueView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -150)
        ])
        
    }

    @IBAction func testButton(_ sender: Any) {
        //let tempConstraint: NSLayoutConstraint = self.yellowViewBottomAnchor
        
        // MARK: Test case 1 - storyboard IBOutlet NSLayoutConstraint
        self.yellowViewBottomAnchor.isActive = false

        print(self.yellowViewBottomAnchor)

        self.yellowViewBottomAnchor.isActive = true;
        
        // MARK: Test case 2 - code-based autolayout
//        self.blueViewBottomAnchor.isActive = false
//
//        print(self.blueViewBottomAnchor)
//
//        self.blueViewBottomAnchor.isActive = true;
        
        // MARK: Another test case - view reference count
//        self.yellowView.removeFromSuperview()
    }
    
}

