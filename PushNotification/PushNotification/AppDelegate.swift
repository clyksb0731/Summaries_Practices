//
//  AppDelegate.swift
//  PushNotification
//
//  Created by 최용석 on 2018. 6. 12..
//  Copyright © 2018년 clyksb0731. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
                
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            })
            
        } else {
            let _ = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("APNs device token: \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Push notification received: \(userInfo)")
        if let tmpMsg = userInfo as? [String : Any] {
            if let deepMsg = tmpMsg["aps"] as? [String : Any] {
                if let finalMsg = deepMsg["alert"] as? [String : String] {
                    print("BODY: ", finalMsg["body"])
                    print("TITLE: ", finalMsg["title"])
                }
                print("BADGE: ", deepMsg["badge"] as? Int)
            }
        }
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("WillPresent Notification")
        
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive Response")
        
        let userInfo = response.notification.request.content.userInfo
        print("Push notification received: \(userInfo)")
        if let tmpMsg = userInfo as? [String : Any] {
            if let deepMsg = tmpMsg["aps"] as? [String : Any] {
                if let finalMsg = deepMsg["alert"] as? [String : String] {
                    print("BODY: ", finalMsg["body"])
                    print("TITLE: ", finalMsg["title"])
                }
                print("BADGE: ", deepMsg["badge"] as? Int)
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber += 1
        
        completionHandler()
    }
}

