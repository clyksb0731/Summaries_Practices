//
//  ViewController.swift
//  PointTest
//
//  Created by Yongseok Choi on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstLevelView: UIView!
    @IBOutlet weak var secondLevelView: UIView!
    @IBOutlet weak var thirdLevelView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureForSecondView = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        let tapGestureForThirdView = UITapGestureRecognizer(target: self, action: #selector(anotherTapGesture(_:)))
        self.secondLevelView.addGestureRecognizer(tapGestureForSecondView)
        self.thirdLevelView.addGestureRecognizer(tapGestureForThirdView) // If this is active, the second gesture can't affect on the third view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = event?.allTouches?.first {
            let point = touch.location(in: touch.view)
            
            if touch.view === self.firstLevelView {
                print("-First Level View-\n")
            }
            
            if touch.view === self.secondLevelView {
                print("-Second Level View-\n")
            }
            
            if touch.view === self.thirdLevelView {
                print("-Third Level View-\n")
            }
            
            print("X point: \(point.x) Y point: \(point.y)")
        }
    }


    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        
        print("From Gesture - X point: \(point.x) Y point: \(point.y)")
    }
    
    @objc func anotherTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        
        print("From Another Gesture - X point: \(point.x) Y point: \(point.y)")
    }
}

