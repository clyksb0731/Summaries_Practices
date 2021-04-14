//
//  AppDelegate.swift
//  ContainerViewControllerTest
//
//  Created by Yongseok Choi on 2021/04/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.view.backgroundColor = .blue
        self.window?.rootViewController = naviVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

