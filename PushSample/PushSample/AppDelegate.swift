//
//  AppDelegate.swift
//  PushSample
//
//  Created by 최용석 on 11/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            
        })
        
        UNUserNotificationCenter.current().delegate = self
        self.setUNCategories()
        
        application.registerForRemoteNotifications()
        
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
        print("Background: \(userInfo)")
        
        let topVC = self.getTopVC(self.window?.rootViewController)
        let tmpVC = UIViewController()
        tmpVC.view.backgroundColor = .yellow
        
        topVC?.present(tmpVC, animated: true)
        
        
        
        if let tmpMsg = userInfo as? [String : Any] {
            if let deepMsg = tmpMsg["aps"] as? [String : Any] {
                if let finalMsg = deepMsg["alert"] as? [String : String] {
                    print("BODY: ", finalMsg["body"])
                    print("TITLE: ", finalMsg["title"])
                }
                print("BADGE: ", deepMsg["badge"] as? Int)
            }
        }
        
        completionHandler(.newData)
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
        self.getNotifications("applicationDidBecomeActive")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: Get Top ViewController
    func getTopVC(_ windowRootVC: UIViewController?) -> UIViewController? {
        var topVC = windowRootVC
        while true {
            if let top = topVC?.presentedViewController {
                topVC = top
            } else if let base = topVC as? UINavigationController, let top = base.visibleViewController {
                topVC = top
            } else if let base = topVC as? UITabBarController, let top = base.selectedViewController {
                topVC = top
            } else {
                break
            }
        }
        
        return topVC
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Fetch Performed ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ")
        
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func setUNCategories() {
        let firstAction = UNNotificationAction(identifier: "first", title: "Foreground", options: [.foreground])
        let secondAction = UNNotificationAction(identifier: "second", title: "Destructive", options: [.destructive])
        let category = UNNotificationCategory(identifier: "category", actions: [firstAction, secondAction], intentIdentifiers: [], options: [])
        
        let oneAction = UNNotificationAction(identifier: "one", title: "One", options: [.foreground])
        let twoAction = UNNotificationAction(identifier: "two", title: "Two", options: [.foreground])
        let threeAction = UNNotificationAction(identifier: "three", title: "Three", options: [.destructive])
        let numbers = UNNotificationCategory(identifier: "number", actions: [oneAction, twoAction, threeAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category, numbers])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        print("willPresent Notification: \(userInfo)")
        
        var topVC = self.getTopVC(self.window?.rootViewController)
        let tmpVC = UIViewController()
        tmpVC.view.backgroundColor = .yellow
        
        topVC?.present(tmpVC, animated: true)
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Before getNotification(_:)")
        print(response.notification.request.content.userInfo)
        
        self.getNotifications("didReceie")
        
        print("After getNotification(_:)")
        print(response.notification.request.content.userInfo)
        
//        let userInfo = response.notification.request.content.userInfo
//
//        switch response.notification.request.content.categoryIdentifier {
//        case "category":
//            switch response.actionIdentifier {
//            case "first":
//                print("did FIRST in category category")
//                print("didReceive Response: \(userInfo)")
//                UIApplication.shared.applicationIconBadgeNumber = 0
//            case "second":
//                print("did SECOND in category category")
//                UIApplication.shared.applicationIconBadgeNumber += 1
//            default:
//                print("Default Tapped in category category")
//            }
//        case "number":
//            switch response.actionIdentifier {
//            case "one":
//                print("did ONE in number category")
//                print("didReceive Response: \(userInfo)")
//                UIApplication.shared.applicationIconBadgeNumber = 0
//            case "two":
//                print("did TWO in number category")
//                print("didReceive Response: \(userInfo)")
//                UIApplication.shared.applicationIconBadgeNumber = 0
//            case "three":
//                print("did THREE in number category")
//                UIApplication.shared.applicationIconBadgeNumber += 1
//            default:
//                print("Default Tapped in number category")
//            }
//        default:
//            print("no category")
//        }
//
//
//        var topVC = self.getTopVC(self.window?.rootViewController)
//        let tmpVC = UIViewController()
//        tmpVC.view.backgroundColor = .yellow
//
//        topVC?.present(tmpVC, animated: true)
//
//
//        //        if let tmpMsg = userInfo as? [String : Any] {
//        //            if let deepMsg = tmpMsg["aps"] as? [String : Any] {
//        //                if let finalMsg = deepMsg["alert"] as? [String : String] {
//        //                    print("BODY: ", finalMsg["body"])
//        //                    print("TITLE: ", finalMsg["title"])
//        //                }
//        //                print("BADGE: ", deepMsg["badge"] as? Int)
//        //            }
//        //        }
//
//
//        completionHandler()
    }
}
