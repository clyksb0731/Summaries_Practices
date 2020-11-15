//
//  AppDelegate.swift
//  PushKitSample
//
//  Created by Yongseok Choi on 2020/03/03.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import UserNotifications
import PushKit
import CallKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var bgTask: UIBackgroundTaskIdentifier = .invalid
    
    var callProvider: CXProvider!
    var callUpdate: CXCallUpdate!
//    var callController: CXCallController!
    var callUUID: UUID!
    var tempUUID: UUID!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.voipRegistration()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .criticalAlert, .badge]) { (granted, error) in
            // Error handling
        }
        
        center.delegate = self
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        if userActivity.activityType == "INStartVideoCallIntent" {
            print("Video Button")
        }

        print("Video Button?")
        
        return true
    }
    
    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        print("Activity Updated")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Push DeviceToken Token: ", deviceToken.reduce("", {$0 + String(format: "%02X", $1)}))
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if self.bgTask != .invalid {
            UIApplication.shared.endBackgroundTask(self.bgTask)
        }
        self.bgTask = .invalid
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("background remote push")
        
//        self.callProvider.reportCall(with: UUID(), endedAt: nil, reason: .remoteEnded)
        self.callProvider.reportCall(with: self.callUUID ?? UUID(), endedAt: nil, reason: .remoteEnded)
        
        self.bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.bgTask)
            self.bgTask = .invalid
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let colorUserInfo = ["color":"after"]
            let numberUserInfo = ["number":"3"]
            NotificationCenter.default.post(name: Notification.Name("changeViewColor"), object: nil, userInfo: colorUserInfo)
            NotificationCenter.default.post(name: Notification.Name("changeViewLabel"), object: nil, userInfo: numberUserInfo)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let numberUserInfo = ["number":"5"]
            let colorUserInfo = ["color":"finally"]
            NotificationCenter.default.post(name: Notification.Name("changeViewColor"), object: nil, userInfo: colorUserInfo)
            NotificationCenter.default.post(name: Notification.Name("changeViewLabel"), object: nil, userInfo: numberUserInfo)
            
            if self.bgTask != .invalid {
                UIApplication.shared.endBackgroundTask(self.bgTask)
            }
            self.bgTask = .invalid
        }
        
        completionHandler(.noData)
    }
    
    func voipRegistration() {
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
        
        let config = CXProviderConfiguration(localizedName: "My App")
        let image = UIImage(named: "appButtonImage")!.withRenderingMode(.alwaysOriginal)
        config.iconTemplateImageData = image.pngData()
        // config.ringtoneSound = "ringtone.caf"
        config.includesCallsInRecents = false;
        config.maximumCallGroups = 1
        config.maximumCallsPerCallGroup = 1
        config.supportedHandleTypes = [.generic]
        config.supportsVideo = true;
        
        self.callProvider = CXProvider(configuration: config)
        self.callProvider.setDelegate(self, queue: nil)
    }
}

// MARK: UserNotifications
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("will Present")
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("did Receive")
        completionHandler()
    }
}

// MARK: PushKit Delegate
extension AppDelegate: PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let deviceTokenString = pushCredentials.token.reduce("", {$0 + String(format: "%02X", $1)})
        print("VoIP push deviceToken :\(deviceTokenString)")
        
        let deviceToken = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
        print("VoIP push deviceToken :\(deviceToken)")
        
        UserDefaults.standard.setValue(deviceTokenString, forKey: "deviceTokenString")
        UserDefaults.standard.setValue(deviceToken, forKey: "deviceToken")
        NotificationCenter.default.post(name: NSNotification.Name("showToken"), object: nil)
    }
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("Push registry failed")
    }
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        let userInfo = payload.dictionaryPayload
        
        print(payload.dictionaryPayload)
        print("Push Type: \(type)")
        // let callID = payload.dictionaryPayload["callID"] as! String
        
        let colorUserInfo = ["color":"before"]
        let numberUserInfo = ["number":"2"]
        NotificationCenter.default.post(name: Notification.Name("changeViewColor"), object: nil, userInfo: colorUserInfo)
        NotificationCenter.default.post(name: Notification.Name("changeViewLabel"), object: nil, userInfo: numberUserInfo)
        
        if let type = userInfo["key"] as? String, type == "start" {
            self.callUUID = UUID()
            if self.tempUUID == nil {
                self.tempUUID = callUUID
            }
            print("AppDelegate Call UUID: \(self.callUUID.uuidString)")
            
            self.callUpdate = CXCallUpdate()
            self.callUpdate.supportsDTMF = false
            self.callUpdate.supportsHolding = false
            self.callUpdate.supportsGrouping = false
            self.callUpdate.supportsUngrouping = false
            self.callUpdate.localizedCallerName = "Test App"
            self.callUpdate.remoteHandle = CXHandle(type: .generic, value: "테스트 이용자")
            self.callUpdate.hasVideo = false
            self.callProvider.reportNewIncomingCall(with: self.callUUID, update: self.callUpdate, completion: { error in
            })
            
        } else {
//            self.callProvider.reportNewIncomingCall(with: self.callUUID, update: self.callUpdate, completion: { error in
//            })
//            self.callProvider.reportCall(with: UUID(), updated: self.callUpdate)
            self.callProvider.reportCall(with: self.callUUID, endedAt: nil, reason: .remoteEnded)
            print("Report Call to End")
            
//            self.bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
//                UIApplication.shared.endBackgroundTask(self.bgTask)
//                self.bgTask = .invalid
//            })
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                if self.bgTask != .invalid {
//                    UIApplication.shared.endBackgroundTask(self.bgTask)
//                }
//                self.bgTask = .invalid
//            }
        }
        
        
        completion()
    }
}
extension AppDelegate: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        print("Did Reset")
    }
    
    func providerDidBegin(_ provider: CXProvider) {
        print("Did Begin")
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        print("Start")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("Answer")
        
//        print("Configuring audio session")
//        let session = AVAudioSession.sharedInstance()
//        do {
//          try session.setCategory(.playAndRecord, mode: .voiceChat, options: [])
//        } catch (let error) {
//          print("Error while configuring audio session: \(error)")
//        }
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("End")
//        action.fulfill(withDateEnded: Date())
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        print("Muted")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        print("Held call")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetGroupCallAction) {
        print("Set group call")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXPlayDTMFCallAction) {
        print("DTMF: \(action.digits)")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, execute transaction: CXTransaction) -> Bool {
        print("Transaction")
        if transaction.isComplete {
            return true

        } else {
            return false
        }
    }
    
    func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
        print("timedOutPerforming")
    }
    
    // Called when the provider's audio session is activated.
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        print("did Active audioSession")
    }
    
    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        print("did Deactive audioSession")
    }
}

