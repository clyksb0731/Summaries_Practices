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
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var uuidValue: UILabel!
    @IBOutlet weak var majorValue: UILabel!
    @IBOutlet weak var minorValue: UILabel!
    
    @IBOutlet weak var beaconDistance: UILabel!
    
    var rangeBeacon: CLBeaconRegion!
    var myBeacon: CLBeaconRegion!
    var myPeripheralData: NSDictionary!
    var myPeripheralManager: CBPeripheralManager!
    
    var locationManager: CLLocationManager!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rangeBeacon = CLBeaconRegion(uuid: UUID(uuidString: "2738C657-0FA5-4479-8867-07B865C52866")!, major: 123, minor: 456, identifier: "rangeBeaconIdentifier")
//        self.rangeBeacon = CLBeaconRegion(uuid: UUID(uuidString: "2738C657-0FA5-4479-8867-07B865C52866")!, identifier: "rangeBeaconIdentifier")
//        self.rangeBeacon = CLBeaconRegion(uuid: UUID(), major: 11, minor: 22, identifier: "rangeBeaconIdentifier")
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    @IBAction func iBeaconSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.myBeacon = CLBeaconRegion(uuid: UUID(uuidString: "B35284F7-1478-47A3-A1A5-F61B7FA74689")!, major: 123, minor: 456, identifier: "myBeaconIdentifier")
//            self.myBeacon = CLBeaconRegion(uuid: UUID(uuidString: "2738C657-0FA5-4479-8867-07B865C52866")!, major: 123, minor: 456, identifier: "myBeaconIdentifier")
            self.myPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
            
        } else {
            self.myPeripheralManager.stopAdvertising()
            self.myPeripheralManager = nil
            self.myBeacon = nil
        }
    }
    
    @IBAction func startRquestAPIRepeatly(_ sender: UIButton) {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(requestAPI(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopRequestAPI(_ sender: UIButton) {
        self.timer.invalidate()
    }
    
    
    @objc func requestAPI(_ timer: Timer) {
        print("will REQUEST:::::::::::::::::\(Date())")
        //let getUrl = "https://postb.in/1586691930287-9430513586848?hello=world"
        let postUrl = "https://postb.in/1586693517941-4678373667411"
        let parameters: Parameters = ["hello":"world"]
        
        Alamofire.request(postUrl, method: .post, parameters: parameters).validate().response { (response) in
            if let statusCode = response.response?.statusCode {
                print("Status Code: \(statusCode)")
                
                if statusCode == 200 {
                    print("Succeeded in requesting API \(Date())")
                    
                } else {
                    print("Failed to request API \(Date())")
                }
            }
        }
        
//        Alamofire.request(getUrl, method: .get, parameters: nil, headers: nil).validate().responseJSON { (response) in
//            switch response.result {
//            case .success(_):
//                print("succeeded in Requesting::::::::::::: \(Date())")
//
//            case .failure(let error):
//                print("failed to request:::::::::::::: \(Date())")
//                print("Error: " + error.localizedDescription)
//            }
//        }
        
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

extension ViewController: CLLocationManagerDelegate {
    // 위치 서비스에 대한 권한이 받아들여지면 MonitorBeacons() 함수 호출
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            self.monitorBeacons()
        }
    }

    // Monitoring 진행이 가능한 상태면 Monitoring 진행
    func monitorBeacons(){
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            // 디바이스가 이미 영역 안에 있거나 앱이 실행되고 있지 않은 상황에서도 영역 내부 안에 들어오면 백그라운드에서 앱을 실행시켜
            // 헤당 노티피케이션을 받을 수 있게 함
            self.rangeBeacon.notifyEntryStateOnDisplay = true
            // 영역 안에 들어온 순간이나 나간 순간에 해당 노티피케이션을 받을 수 있게 함
            self.rangeBeacon.notifyOnExit = true
            self.rangeBeacon.notifyOnEntry = true
            self.locationManager.startMonitoring(for: self.rangeBeacon)
        }else{
            print("CLLocation Monitoring is unavailable")
        }
    }
    
    
    // 모니터링이 실행된 후 영역의 판단이 이루어지는 순간에 이 메소드가 실행
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {        // 영역 안에 들어온 순간
            self.locationManager.startRangingBeacons(in: self.rangeBeacon)
            print("Inside")
            
        }else if state == .outside { // 영역 밖에 나간 순간
            self.locationManager.stopRangingBeacons(in: self.rangeBeacon)
            print("Outside")
            
        }else if state == .unknown {
            print("Now unknown of Region")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        // 연결할 수 있는 비콘이 있는 경우
        if beacons.count > 0 {
            print("Beacon counts is more than 0 !!")
            if let firstBeacon = beacons.first {
                print("Accuracy: \(firstBeacon.accuracy)")
                print("RSSI: \(firstBeacon.rssi)")
            }
            let nearestBeacon = beacons.first!  // 가장 가까이 있는 비콘을 내 비콘으로 잡자.
            // 거리에 맞게 원하는 코드를 작성하면 끝
            switch nearestBeacon.proximity {
            case .immediate:
                break
                    
            case .near:
                break
                    
            case .far:
                break
                    
            case .unknown:
                break
                
            @unknown default:
                fatalError()
            }
            
        } else{
                // 연결할 수 있는 비콘이 없는 경우
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("비콘이 범위 내에 있음")
    }
        
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("비콘이 범위 밖을 벗어남")
    }
}

