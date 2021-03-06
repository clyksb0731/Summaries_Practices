//
//  ViewController.swift
//  CoreLocationSample
//
//  Created by 최용석 on 13/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

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
        
        self.setViewFoundation()
        self.view.addSubview(self.latitudeLabel)
        self.view.addSubview(self.longitudeLabel)
        self.setLayout()
        
        locationManager.delegate = self
        
//        locationManager.allowsBackgroundLocationUpdates = true
//
//        locationManager.pausesLocationUpdatesAutomatically = false
        
        // Status will not be changed with the follwing syntax and it must has both Privacy - Location When In Use Usage Description and Privacy - Location Always and When In Use Usage Description
//        locationManager.requestAlwaysAuthorization()
        
        // Status will be influenced due to the following syntax with plist's Privacy - Location When In Use Usage Description
        locationManager.requestWhenInUseAuthorization()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestLocation()
    }
    
    func setViewFoundation() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.getRGB(65, 189, 219)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        .font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        self.navigationItem.title = "Main View"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightBarButton(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white

    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.latitudeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            self.latitudeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)])
        
        NSLayoutConstraint.activate([
            self.longitudeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.longitudeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100)])
    }
    
    @objc func rightBarButton(_ sender: UIBarButtonItem) {
//        self.locationManager.stopUpdatingLocation()
        
        let nextVC = NextViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            self.latitudeLabel.text = String(lastLocation.coordinate.latitude)
            self.longitudeLabel.text = String(lastLocation.coordinate.longitude)
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                print("place mark:: ", placeMark)
                
                // Location name
                if let location = placeMark.location {
                    print("Location: ", location)
                }
                
                // Location name
                if let region = placeMark.region {
                    print("Region: ", region)
                }
                
                // Location name
                if let isoCountryCode = placeMark.isoCountryCode {
                    print("ISO country code: ", isoCountryCode)
                }
                
                // Location name
                if let postalAddress = placeMark.postalAddress {
                    print("Mailing Address: ", CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress))
                    print("Postal address: ", postalAddress)
                }
                
                // Location name
                if let state = placeMark.administrativeArea {
                    print("State: ", state)
                }
                
                // Location name
                if let subState = placeMark.subAdministrativeArea {
                    print("Sub state: ", subState)
                }
                
                // Location name
                if let name = placeMark.name {
                    print("Name: ", name)
                }
                
                // Street address
                if let street = placeMark.thoroughfare {
                    print("Street: ", street)
                }
                
                // City
                if let city = placeMark.locality {
                    print("City: ", city)
                }
                
                // subLocality
                if let subLocality = placeMark.subLocality {
                    print("Sub locality: ", subLocality)
                }
                
                // subThoroughfare
                if let subThoroughfare = placeMark.subThoroughfare {
                    print("Sub thoroughfare: ", subThoroughfare)
                }
                
                // Zip code
                if let zip = placeMark.postalCode {
                    print("postalcode: ", zip)
                }
                
                // Country
                if let country = placeMark.country {
                    print("Country: ", country)
                }
                
            })
            
            
            
            
            NotificationCenter.default.post(name: NSNotification.Name("updateMainLocation"), object: nil, userInfo: ["values":["latitude":lastLocation.coordinate.latitude, "longitude":lastLocation.coordinate.longitude]])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error:: ", error.localizedDescription)
    }
}

extension UIColor {
    static func getRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

