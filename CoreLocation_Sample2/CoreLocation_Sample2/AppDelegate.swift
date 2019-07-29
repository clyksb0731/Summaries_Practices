//
//  AppDelegate.swift
//  CoreLocation_Sample2
//
//  Created by Yongseok Choi on 29/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let locationManager: CLLocationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.locationManager.stopMonitoringSignificantLocationChanges()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.locationManager.showsBackgroundLocationIndicator = true
        let center1 = CLLocationCoordinate2D(latitude: 37.362865, longitude: 127.158420)
        let center2 = CLLocationCoordinate2D(latitude: 37.413707, longitude: 127.098777)
        let region1 = CLCircularRegion(center: center1, radius: 100, identifier: "test")
        let region2 = CLCircularRegion(center: center2, radius: 100, identifier: "test2")
        region1.notifyOnEntry = true
        region2.notifyOnEntry = true
        region1.notifyOnExit = true
        region2.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: region1)
        self.locationManager.startMonitoring(for: region2)
        
        //        self.locationManager.startUpdatingLocation()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if !granted {
                print("Something wrong for using Notification")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

// MARK: Extension for UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([])
    }
}

// MARK: Extension for CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("always::::::")
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        } else if status == .authorizedWhenInUse {
            print("while using:::::")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print("RecentLocation: ", lastLocation)
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 8
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter region")
        
        if region.identifier == "test" {
            UIApplication.shared.applicationIconBadgeNumber = 11
            
        } else if region.identifier == "test1" {
            UIApplication.shared.applicationIconBadgeNumber = 41
            
        } else {
            UIApplication.shared.applicationIconBadgeNumber = 71
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit region")
        
        if region.identifier == "test" {
            UIApplication.shared.applicationIconBadgeNumber = 12
            
        } else if region.identifier == "test1" {
            UIApplication.shared.applicationIconBadgeNumber = 42
            
        } else {
            UIApplication.shared.applicationIconBadgeNumber = 71
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started Monitoring For Region: ", region)
        
        UIApplication.shared.applicationIconBadgeNumber = 10
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
