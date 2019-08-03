//
//  AppDelegate.swift
//  PushManagement
//
//  Created by Yongseok Choi on 03/08/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .criticalAlert, .badge]) { (granted, error) in
            // Error handling
        }
        
        center.delegate = self
        
        application.registerForRemoteNotifications()
        
        
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
        
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            print("didBecomeActive: ", notifications)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DeviceToken Token: ", deviceToken.reduce("", {$0 + String(format: "%02X", $1)}))
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UserInfo: ", notification.request.content.userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        center.getDeliveredNotifications { (notifications) in
            print("1")
            for _ in 1...100_000_000 {
                
            }
            center.removeAllDeliveredNotifications()
            center.getDeliveredNotifications(completionHandler: { (notifications2) in
                print("userinfo1", notifications)
            })
            print("11")
        }
        
        center.getDeliveredNotifications { (notifications) in
            print("2")
            for _ in 1...100_000_000 {
                
            }
            center.removeAllDeliveredNotifications()
            center.getDeliveredNotifications(completionHandler: { (notifications2) in
                print("userinfo2", notifications)
            })
            print("22")
        }
        
        center.getDeliveredNotifications { (notifications) in
            print("3")
            for _ in 1...100_000_000 {
                
            }
            center.removeAllDeliveredNotifications()
            center.getDeliveredNotifications(completionHandler: { (notifications2) in
                print("userinfo3", notifications)
            })
            print("33")
        }
        
        center.getDeliveredNotifications { (notifications) in
            print("4")
            for _ in 1...100_000_000 {
                
            }
            center.removeAllDeliveredNotifications()
            center.getDeliveredNotifications(completionHandler: { (notifications2) in
                print("userinfo4", notifications)
            })
            print("44")
        }
        
        center.getDeliveredNotifications { (notifications) in
            print("5")
            for _ in 1...100_000_000 {
                
            }
            center.removeAllDeliveredNotifications()
            center.getDeliveredNotifications(completionHandler: { (notifications2) in
                print("userinfo5", notifications)
            })
            print("55")
        }
        
        DispatchQueue.main.async {
            print(33)
        }
        
        /*
         On console printed
         
         33
         1
         11
         2
         22
         3
         33
         4
         44
         5
         55
         userinfo1 [<UNNotification: 0x28353db00; date: 2019-08-03 09:19:54 +0000, request: <UNNotificationRequest: 0x283b70e10; identifier: 9F39045F-9F0D-438C-8EF0-B579B74BC7AE, content: <UNNotificationContent: 0x280023540; title: Push test ✌, subtitle: third, body: iOS Push Notification, summaryArgument: (null), summaryArgumentCount: 0, categoryIdentifier: Categories, launchImageName: , threadIdentifier: , attachments: (
         ), badge: 1, sound: <UNNotificationSound: 0x281121c20>,, trigger: <UNPushNotificationTrigger: 0x28372c350; contentAvailable: NO, mutableContent: YES>>>]
         didBecomeActive:  []
         userinfo2 [<UNNotification: 0x28353dbc0; date: 2019-08-03 09:19:54 +0000, request: <UNNotificationRequest: 0x283b71620; identifier: 9F39045F-9F0D-438C-8EF0-B579B74BC7AE, content: <UNNotificationContent: 0x2800233c0; title: Push test ✌, subtitle: third, body: iOS Push Notification, summaryArgument: (null), summaryArgumentCount: 0, categoryIdentifier: Categories, launchImageName: , threadIdentifier: , attachments: (
         ), badge: 1, sound: <UNNotificationSound: 0x281121b60>,, trigger: <UNPushNotificationTrigger: 0x28372c630; contentAvailable: NO, mutableContent: YES>>>]
         userinfo3 [<UNNotification: 0x283539560; date: 2019-08-03 09:19:54 +0000, request: <UNNotificationRequest: 0x283b6f900; identifier: 9F39045F-9F0D-438C-8EF0-B579B74BC7AE, content: <UNNotificationContent: 0x280024480; title: Push test ✌, subtitle: third, body: iOS Push Notification, summaryArgument: (null), summaryArgumentCount: 0, categoryIdentifier: Categories, launchImageName: , threadIdentifier: , attachments: (
         ), badge: 1, sound: <UNNotificationSound: 0x28112c4e0>,, trigger: <UNPushNotificationTrigger: 0x2837208d0; contentAvailable: NO, mutableContent: YES>>>]
         userinfo4 []
         userinfo5 []
        */
    }
}

