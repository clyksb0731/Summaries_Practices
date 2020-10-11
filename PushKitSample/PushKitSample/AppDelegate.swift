//
//  AppDelegate.swift
//  PushKitSample
//
//  Created by Yongseok Choi on 2020/03/03.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import PushKit
import CallKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var callProvider: CXProvider!
    var callUpdate: CXCallUpdate!
//    var callController: CXCallController!
    var callUUID: UUID!
    var tempUUID: UUID!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.voipRegistration()
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
        config.supportsVideo = true;
        
        self.callProvider = CXProvider(configuration: config)
        self.callProvider.setDelegate(self, queue: nil)
    }
}
// MARK: PushKit Delegate
extension AppDelegate: PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let deviceTokenString = pushCredentials.token.reduce("", {$0 + String(format: "%02X", $1)})
        print("pushRegistry -> deviceToken :\(deviceTokenString)")
        let deviceToken = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
        print("pushRegistry -> deviceToken :\(deviceToken)")
        UserDefaults.standard.setValue(deviceTokenString, forKey: "deviceTokenString")
        UserDefaults.standard.setValue(deviceToken, forKey: "deviceToken")
        NotificationCenter.default.post(name: NSNotification.Name("showToken"), object: nil)
    }
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("Push registry failed")
    }
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print(payload.dictionaryPayload)
        print("Push Type: \(type)")
        // let callID = payload.dictionaryPayload["callID"] as! String
        self.callUUID = UUID()
        if self.tempUUID == nil {
            self.tempUUID = callUUID
        }
        print("AppDelegate Call UUID: \(self.callUUID.uuidString)")
        
        self.callUpdate = CXCallUpdate()
        //self.callUpdate.supportsDTMF = false
        self.callUpdate.supportsHolding = false
        self.callUpdate.supportsGrouping = false
        self.callUpdate.supportsUngrouping = false
        //self.callUpdate.localizedCallerName = "test"
        self.callUpdate.remoteHandle = CXHandle(type: .phoneNumber, value: "010-1111-2222")
        self.callUpdate.hasVideo = false
        self.callProvider.reportNewIncomingCall(with: self.callUUID, update: self.callUpdate, completion: { error in
        })
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

