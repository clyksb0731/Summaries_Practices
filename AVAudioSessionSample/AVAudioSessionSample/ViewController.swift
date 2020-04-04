//
//  ViewController.swift
//  AVAudioSessionSample
//
//  Created by Yongseok Choi on 2020/03/20.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var outputPortDescriptionPortTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCurrentAudioPortType()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentAudioPortType(_:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    func getCurrentAudioPortType() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord)
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if let currentOutputPort = currentRoute.outputs.first {
            if currentOutputPort.portType == .airPlay {
                
            } else if currentOutputPort.portType == .bluetoothA2DP {
                self.outputPortDescriptionPortTypeLabel.text = "bluetoothA2DP"
                
            } else if currentOutputPort.portType == .bluetoothHFP {
                self.outputPortDescriptionPortTypeLabel.text = "bluetoothHFP"
                
            } else if currentOutputPort.portType == .bluetoothLE {
                self.outputPortDescriptionPortTypeLabel.text = "bluetoothLE"
                
            } else if currentOutputPort.portType == .builtInMic {
                self.outputPortDescriptionPortTypeLabel.text = "builtInMic"
                
            } else if currentOutputPort.portType == .builtInReceiver {
                self.outputPortDescriptionPortTypeLabel.text = "builtInReceiver"
                
            } else if currentOutputPort.portType == .builtInSpeaker {
                self.outputPortDescriptionPortTypeLabel.text = "builtInSpeaker"
                
            } else if currentOutputPort.portType == .carAudio {
                self.outputPortDescriptionPortTypeLabel.text = "carAudio"
                
            } else if currentOutputPort.portType == .HDMI {
                self.outputPortDescriptionPortTypeLabel.text = "HDMI"
                
            } else if currentOutputPort.portType == .headphones {
                self.outputPortDescriptionPortTypeLabel.text = "headphones"
                
            } else if currentOutputPort.portType == .headsetMic {
                self.outputPortDescriptionPortTypeLabel.text = "headsetMic"
                
            } else if currentOutputPort.portType == .lineIn {
                self.outputPortDescriptionPortTypeLabel.text = "lineIn"
                
            } else if currentOutputPort.portType == .lineOut {
                self.outputPortDescriptionPortTypeLabel.text = "lineOut"
                
            } else if currentOutputPort.portType == .usbAudio {
                self.outputPortDescriptionPortTypeLabel.text = "usbAudio"
            }
        }
    }
    
    @objc func setCurrentAudioPortType(_ notification: Notification) {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord)
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if let currentOutputPort = currentRoute.outputs.first {
            if currentOutputPort.portType == .airPlay {
                
            } else if currentOutputPort.portType == .bluetoothA2DP {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "bluetoothA2DP"
                }
                
            } else if currentOutputPort.portType == .bluetoothHFP {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "bluetoothHFP"
                }
                
            } else if currentOutputPort.portType == .bluetoothLE {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "bluetoothLE"
                }
                
            } else if currentOutputPort.portType == .builtInMic {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "builtInMic"
                }
                
            } else if currentOutputPort.portType == .builtInReceiver {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "builtInReceiver"
                }
                
            } else if currentOutputPort.portType == .builtInSpeaker {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "builtInSpeaker"
                }
                
            } else if currentOutputPort.portType == .carAudio {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "carAudio"
                }
                
            } else if currentOutputPort.portType == .HDMI {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "HDMI"
                }
                
            } else if currentOutputPort.portType == .headphones {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "headphones"
                }
                
            } else if currentOutputPort.portType == .headsetMic {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "headsetMic"
                }
                
            } else if currentOutputPort.portType == .lineIn {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "lineIn"
                }
                
            } else if currentOutputPort.portType == .lineOut {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "lineOut"
                }
                
            } else if currentOutputPort.portType == .usbAudio {
                DispatchQueue.main.async {
                    self.outputPortDescriptionPortTypeLabel.text = "usbAudio"
                }
            }
        }
    }
    
    @IBAction func headphoneButton(_ sender: UIButton) {
        let audioSession = AVAudioSession.sharedInstance()
        
        try? audioSession.overrideOutputAudioPort(.none)
    }
    
    @IBAction func speakerButton(_ sender: UIButton) {
        let audioSession = AVAudioSession.sharedInstance()
        
        try? audioSession.overrideOutputAudioPort(.speaker)
    }
    
    
}

