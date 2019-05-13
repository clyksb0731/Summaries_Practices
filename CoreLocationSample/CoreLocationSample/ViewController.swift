//
//  ViewController.swift
//  CoreLocationSample
//
//  Created by 최용석 on 13/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var latitudeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    var longitudeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.latitudeLabel)
        self.view.addSubview(self.longitudeLabel)
        self.setLayout()
        
        locationManager.delegate = self
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        // Status will not be changed with the follwing syntax and it must has both Privacy - Location When In Use Usage Description and Privacy - Location Always and When In Use Usage Description
//        locationManager.requestAlwaysAuthorization()
        
        // Status will be influenced due to the following syntax with plist's Privacy - Location When In Use Usage Description
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.latitudeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            self.latitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
        
        NSLayoutConstraint.activate([
            self.longitudeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.longitudeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100)])
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(self.locationManager.location?.coordinate)
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            self.latitudeLabel.text = String(lastLocation.coordinate.latitude)
            self.longitudeLabel.text = String(lastLocation.coordinate.longitude)
        }
    }
}

