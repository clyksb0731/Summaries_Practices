//
//  ViewController.swift
//  QRCodeReader
//
//  Created by 최용석 on 30/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var cameraView: UIView!
    var centerReaderView: UIView!
    var coverView: UIView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.instantiateViews()
        self.setTargets()
        self.setGestures()
        self.setDelegates()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewFoundation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startReadQRCode()
    }
    
    deinit {
        print("----------------------------------- TemplateViewController disposed -----------------------------------")
    }
}

// MARK: Extension for overrided methods
extension ViewController {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

// Extension for Methods added
extension ViewController {
    /**
     */
    func instantiateViews() {
        self.cameraView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.centerReaderView = {
            let view = UIView()
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 2
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.coverView = {
            let view = UIView()
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.captureSession = AVCaptureSession()
        
        self.previewLayer = {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            
            return previewLayer
        }()
    }
    
    /**
     */
    func setViewFoundation() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .gray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        .font:UIFont.systemFont(ofSize: 17, weight: .medium)]
        self.navigationItem.title = "QR Code Reader"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(leftBarButton(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    /**
     */
    func setTargets() {
        
    }
    
    /**
     */
    func setGestures() {
        
    }
    
    /**
     */
    func setDelegates() {
        
    }
    
    /**
     */
    func setNotificationCenters() {
        
    }
    
    /**
     */
    func setSubviews() {
        self.view.addSubview(self.cameraView)
        self.view.addSubview(self.centerReaderView)
        self.view.addSubview(self.coverView)
    }
    
    /**
     */
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.cameraView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.cameraView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.cameraView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.cameraView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.centerReaderView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.centerReaderView.heightAnchor.constraint(equalToConstant: 200),
            self.centerReaderView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.centerReaderView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
    
    /**
     */
    func startReadQRCode() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("Not supported")
            
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Not supported")
            
            return
        }
        
        self.previewLayer.frame = self.cameraView.bounds
        self.cameraView.layer.addSublayer(self.previewLayer)
        
        self.captureSession.startRunning()
        self.coverView.isHidden = true
        
        self.view.bringSubviewToFront(self.centerReaderView)
    }
}

// MARK: Extension for objc methods added
extension ViewController {
    @objc func leftBarButton(_ sender: UIBarButtonItem) {
        if !self.captureSession.isRunning {
            self.captureSession.startRunning()
        }
    }
}

// MARK: Extension for AVCaptureMetadataOutputObjectsDelegate
extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        
        print("Object", metadataObjects)
        
        for object in metadataObjects {
            print("objects: ", object)
        }
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            print("Readable")
            print(readableObject)
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            print("QR Code::::::: ", stringValue)
        }
    }
}
