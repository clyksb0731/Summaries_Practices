//
//  ViewController.swift
//  CoreBluetoothPractice
//
//  Created by Yongseok Choi on 2021/09/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionStateView: UIView!
    @IBOutlet weak var synchronizingSwitch: UISwitch!
    @IBOutlet weak var sendingTextField: UITextField!
    @IBOutlet weak var receivedMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connectionStateView.layer.cornerRadius = 25/2
        
    }

    @IBAction func synchronizingSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func sendingMessageButton(_ sender: Any) {
    }
    
    @IBAction func openVCToConnectBT(_ sender: UIButton) {
    }
}


