//
//  PushExtension.swift
//  PushSample
//
//  Created by 최용석 on 01/06/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import UserNotifications

extension AppDelegate {
    // MARK: Get notifications delivered and pending
    func getNotifications(_ center: UNUserNotificationCenter = UNUserNotificationCenter.current(),
                          delete identifiers: [String]? = nil) {
        
        if let identifiers = identifiers {
            center.removeDeliveredNotifications(withIdentifiers: identifiers)
        }
        
        center.getDeliveredNotifications { (notifications) in
            for notification in notifications {
                // Need to determine thread
                print(notification.request.content.userInfo) // Here to handle notifications
            }
            
            center.removeAllDeliveredNotifications()
        }
    }
}
