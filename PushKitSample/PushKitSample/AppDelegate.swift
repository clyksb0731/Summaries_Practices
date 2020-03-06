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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.voipRegistration()
        
        return true
    }
    
    func voipRegistration() {
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
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
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("Push registry failed")
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        print(payload.dictionaryPayload)
        print("Push Type: \(type)")
        // let callID = payload.dictionaryPayload["callID"] as! String
        
        self.callUUID = UUID()
        print("AppDelegate Call UUID: \(self.callUUID.uuidString)")
        
        let config = CXProviderConfiguration(localizedName: "My App")
        config.iconTemplateImageData = UIImage(named: "Neo")!.pngData()
        // config.ringtoneSound = "ringtone.caf"
        config.includesCallsInRecents = false;
        config.supportsVideo = false;
        self.callProvider = CXProvider(configuration: config)
        self.callProvider.setDelegate(self, queue: nil)
        self.callUpdate = CXCallUpdate()
        self.callUpdate.remoteHandle = CXHandle(type: .generic, value: "Pete Za")
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
        
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("End")
        
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
    
    // Called when the provider’s audio session is activated.
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        // start audio
    }
}

