//
//  AppDelegate.swift
//  ViewSlideSample
//
//  Created by Yongseok Choi on 2020/03/12.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let naviVC = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = naviVC
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

