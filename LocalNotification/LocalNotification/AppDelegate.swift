//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by 최용석 on 2018. 6. 3..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Notification authorization.
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            // center.requestAuthorization(options: [.alert])
            // center.requestAuthorization(options: [.alert, .sound])
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("We have permission")
                } else {
                    print("Permision denied")
                }
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Hello!"
            content.body = "I am a local notification"
            content.sound = UNNotificationSound.default()
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
            
            center.add(request, withCompletionHandler: nil)
            
        } else {
            // TODO: add the previous version's syntax here.
        }
                
        return true
    }
    
    // MARK: - User Notification Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received local notification \(notification)")
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

