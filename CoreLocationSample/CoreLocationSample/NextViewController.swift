//
//  NextViewController.swift
//  CoreLocationSample
//
//  Created by 최용석 on 23/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import CoreLocation

class NextViewController: UIViewController {
    
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
    
    var mainLatitudeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    var mainLongitudeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()

    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        
        self.setViewFoundation()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    deinit {
        print("----------------------------- NextViewController -------------------------")
    }

}

extension NextViewController {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.getRGB(65, 189, 219)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        .font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        self.navigationItem.title = "Next View"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButton(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMainLocationInformation(_:)), name: NSNotification.Name(rawValue: "updateMainLocation"), object: nil)
    }
    
    func setSubviews() {
        self.view.addSubview(self.latitudeLabel)
        self.view.addSubview(self.longitudeLabel)
        self.view.addSubview(self.mainLatitudeLabel)
        self.view.addSubview(self.mainLongitudeLabel)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            self.latitudeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.latitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
        
        NSLayoutConstraint.activate([
            self.longitudeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.longitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
        
        NSLayoutConstraint.activate([
            self.mainLatitudeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            self.mainLatitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
        
        NSLayoutConstraint.activate([
            self.mainLongitudeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400),
            self.mainLongitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
    }
    
    @objc func rightBarButton(_ sender: UIBarButtonItem) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            self.locationManager.startUpdatingLocation()
        }
    }
    
    @objc func updateMainLocationInformation(_ notification: Notification) {        
        if let userInfo = notification.userInfo as? [String:[String:CLLocationDegrees]] {
            self.mainLatitudeLabel.text = String(userInfo["values"]!["latitude"]!)
            self.mainLongitudeLabel.text = String(userInfo["values"]!["longitude"]!)
        }
    }
}

extension NextViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            self.latitudeLabel.text = String(lastLocation.coordinate.latitude)
            self.longitudeLabel.text = String(lastLocation.coordinate.longitude)
        }
    }
}
