//
//  ViewController.swift
//  BeaconSample
//
//  Created by Yongseok Choi on 2020/04/10.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var uuidValue: UILabel!
    @IBOutlet weak var majorValue: UILabel!
    @IBOutlet weak var minorValue: UILabel!
    
    var myBeacon: CLBeaconRegion!
    var myPeripheralData: NSDictionary!
    var myPeripheralManager: CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startAdvertising(_ sender: UIButton) {
        self.myBeacon = CLBeaconRegion(uuid: UUID(uuidString: "B35284F7-1478-47A3-A1A5-F61B7FA74689")!, major: 123, minor: 456, identifier: "myBeaconIdentifier")
        self.myPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    @IBAction func stopAdvertising(_ sender: UIButton) {
        self.myPeripheralManager.stopAdvertising()
        self.myPeripheralManager = nil
        self.myBeacon = nil
    }
    
    
}

extension ViewController: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            self.uuidValue.text = self.myBeacon.uuid.uuidString
            self.majorValue.text = "\(self.myBeacon.major!)"
            self.minorValue.text = "\(self.myBeacon.minor!)"
            
            print("Power On")
            self.myPeripheralData = self.myBeacon.peripheralData(withMeasuredPower: nil)
            self.myPeripheralManager.startAdvertising(self.myPeripheralData as? [String:Any])
            
//            let serviceUUID = CBUUID(string: "B35284F7-1478-47A3-A1A5-F61B7FA74689")
//            let service = CBMutableService(type: serviceUUID, primary: true)
//            self.myPeripheralManager.add(service)
//            self.myPeripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey: "Yongs iPhone",
//            CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
            
        } else if peripheral.state == .poweredOff {
            print("Power Off")
            self.myPeripheralManager.stopAdvertising()
            
        } else if peripheral.state == .unsupported {
            print("Unsupported")
            
        } else {
            print("Else")
        }
    }
    
    
}

