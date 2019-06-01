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
    func getNotifications(_ place: String) {
        let notificationManger = UNUserNotificationCenter.current()
        notificationManger.getDeliveredNotifications { (notifications) in
            for notification in notifications {
                print("Where code is running at [\(place)]")
                print(notification.request.content.userInfo)
            }
            
            notificationManger.removeAllDeliveredNotifications()
        }
    }
}
