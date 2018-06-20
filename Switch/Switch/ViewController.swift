//
//  ViewController.swift
//  Switch
//
//  Created by 최용석 on 2018. 6. 20..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let sw1: UISwitch = UISwitch()
    let sw2: UISwitch = UISwitch()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // set object on the center of X and Y
        sw1.translatesAutoresizingMaskIntoConstraints = false
        sw1.tag = 1
        sw1.isOn = true
        sw1.addTarget(self, action: #selector(reactForSW(_:)), for: .valueChanged)
        self.view.addSubview(sw1)
        
//        sw1.heightAnchor.constraint(equalToConstant: 31).isActive = true
//        sw1.widthAnchor.constraint(equalToConstant: 51).isActive = true
        safeGuide.centerXAnchor.constraint(equalTo: sw1.centerXAnchor).isActive = true
        safeGuide.centerYAnchor.constraint(equalTo: sw1.centerYAnchor).isActive = true
        
        
        // set object position with top and leading
        sw2.tag = 2
        sw2.setOn(true, animated: true)
        sw2.addTarget(self, action: #selector(reactForSW(_:)), for: .valueChanged)
        sw2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sw2)
        
        safeGuide.topAnchor.constraint(equalTo: sw2.topAnchor, constant: -100).isActive = true
//        safeGuide.bottomAnchor.constraint(equalTo: , constant: ).isActive = true
        safeGuide.leadingAnchor.constraint(equalTo: sw2.leadingAnchor, constant: (-375+51)/2).isActive = true
//        safeGuide.trailingAnchor.constraint(equalTo: , constant: ).isActive = true
        
        // Button to set the state of sw objects
        button.setTitle("On/Off", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeSW(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        safeGuide.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        safeGuide.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
    }
    
    @objc func reactForSW(_ sender: UISwitch) {
        if sender.isOn {
            print("On")
            print(sender)
        } else {
            print("Off")
            print(sender)
        }
    }
    
    // set switches to On or Off
    @objc func changeSW(_ sender: UIButton) {
        // upper sw is sw2 in simulator
        if self.sw1.isOn && self.sw2.isOn {
            self.sw1.setOn(false, animated: true)
            self.sw2.setOn(false, animated: false)
        } else {
//            self.sw1.setOn(true, animated: false)
            self.sw1.isOn = true
            self.sw2.setOn(true, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

