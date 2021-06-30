//
//  AppDelegate.swift
//  NavigationBarTest
//
//  Created by Yongseok Choi on 2021/06/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.initialVC()
        
        return true
    }
    
    func initialVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = UINavigationController(rootViewController: storyboard.instantiateInitialViewController() as! ViewController)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = naviVC
        
        self.window?.makeKeyAndVisible()
    }
}

