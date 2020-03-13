//
//  ViewController.swift
//  CameraHandling
//
//  Created by Yongseok Choi on 2020/03/02.
//  Copyright © 2020 Yongseok Choi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession: AVCaptureSession = {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        return captureSession
    }()
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var cameraView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var buttonsView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var frontCameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("Front", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var wideCameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Wide", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var ultraWideCameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("U-Wide", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var telephotoCameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Telephoto", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var captureDeviceTypes: [AVCaptureDevice.DeviceType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.setTargets()
        self.setGestures()
        self.setDelegates()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.determineOrientation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.initializeCamera()
    }

}

// MARK: - Essential Methods
extension ViewController {
    // MARK: Set view foundation
    func setViewFoundation() {
        self.view.backgroundColor = .white
    }
    
    // MARK: Set targets
    func setTargets() {
        self.frontCameraButton.addTarget(self, action: #selector(frontCameraButton(_:)), for: .touchUpInside)
        self.wideCameraButton.addTarget(self, action: #selector(wideCameraButton(_:)), for: .touchUpInside)
        self.ultraWideCameraButton.addTarget(self, action: #selector(ultraWideCameraButton(_:)), for: .touchUpInside)
        self.telephotoCameraButton.addTarget(self, action: #selector(telephotoCameraButton(_:)), for: .touchUpInside)
    }
    
    // MARK: Set gestures
    func setGestures() {
        
    }
    
    // MARK: Set delegates
    func setDelegates() {
        
    }
    
    // MARK: Set notificationCenters
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sessionRuntimeError(_:)), name: .AVCaptureSessionRuntimeError, object: nil)
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.addSubviews([
            self.cameraView,
            self.buttonsView
        ], to: self.view)
        
        switch self.determineCameraType() {
        case .single:
            self.addSubviews([
                self.frontCameraButton,
                self.wideCameraButton
            ], to: self.buttonsView)
            
        case .dual(eleven: let eleven):
            switch eleven {
            case true:
                self.addSubviews([
                    self.frontCameraButton,
                    self.wideCameraButton,
                    self.ultraWideCameraButton
                ], to: self.buttonsView)
                
            case false:
                self.addSubviews([
                    self.frontCameraButton,
                    self.wideCameraButton,
                    self.telephotoCameraButton
                ], to: self.buttonsView)
            }
            
        case .triple:
            self.addSubviews([
                self.frontCameraButton,
                self.wideCameraButton,
                self.ultraWideCameraButton,
                self.telephotoCameraButton
            ], to: self.buttonsView)
        }
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // Camera view layout
        NSLayoutConstraint.activate([
            self.cameraView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.cameraView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.8),
            self.cameraView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.cameraView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        // Buttons view layout
        NSLayoutConstraint.activate([
            self.buttonsView.topAnchor.constraint(equalTo: self.cameraView.bottomAnchor),
            self.buttonsView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2),
            self.buttonsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.buttonsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        switch self.determineCameraType() {
        case .single:
            // Front camera button layout
            NSLayoutConstraint.activate([
                self.frontCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.frontCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.frontCameraButton.leadingAnchor.constraint(equalTo: self.buttonsView.leadingAnchor),
                self.frontCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/2)
            ])
            
            // Wide camera button layout
            NSLayoutConstraint.activate([
                self.wideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.wideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.wideCameraButton.leadingAnchor.constraint(equalTo: self.frontCameraButton.trailingAnchor),
                self.wideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/2)
            ])
            
        case .dual(eleven: let eleven):
            switch eleven {
            case true:
                // Front camera button layout
                NSLayoutConstraint.activate([
                    self.frontCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.frontCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.frontCameraButton.leadingAnchor.constraint(equalTo: self.buttonsView.leadingAnchor),
                    self.frontCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
                
                // Wide camera camera button layout
                NSLayoutConstraint.activate([
                    self.wideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.wideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.wideCameraButton.leadingAnchor.constraint(equalTo: self.frontCameraButton.trailingAnchor),
                    self.wideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
                
                // Ultra wide camera button layout
                NSLayoutConstraint.activate([
                    self.ultraWideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.ultraWideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.ultraWideCameraButton.leadingAnchor.constraint(equalTo: self.wideCameraButton.trailingAnchor),
                    self.ultraWideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
                
            case false:
                // Front camera button layout
                NSLayoutConstraint.activate([
                    self.frontCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.frontCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.frontCameraButton.leadingAnchor.constraint(equalTo: self.buttonsView.leadingAnchor),
                    self.frontCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
                
                // Wide camera camera button layout
                NSLayoutConstraint.activate([
                    self.wideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.wideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.wideCameraButton.leadingAnchor.constraint(equalTo: self.frontCameraButton.trailingAnchor),
                    self.wideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
                
                // Telephoto camera button layout
                NSLayoutConstraint.activate([
                    self.telephotoCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                    self.telephotoCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                    self.telephotoCameraButton.leadingAnchor.constraint(equalTo: self.ultraWideCameraButton.trailingAnchor),
                    self.telephotoCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 1/3)
                ])
            }
            
        case .triple:
           // Front camera button layout
            NSLayoutConstraint.activate([
                self.frontCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.frontCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.frontCameraButton.leadingAnchor.constraint(equalTo: self.buttonsView.leadingAnchor),
                self.frontCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 0.25)
            ])
            
            // Wide camera camera button layout
            NSLayoutConstraint.activate([
                self.wideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.wideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.wideCameraButton.leadingAnchor.constraint(equalTo: self.frontCameraButton.trailingAnchor),
                self.wideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 0.25)
            ])
            
            // Ultra wide camera button layout
            NSLayoutConstraint.activate([
                self.ultraWideCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.ultraWideCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.ultraWideCameraButton.leadingAnchor.constraint(equalTo: self.wideCameraButton.trailingAnchor),
                self.ultraWideCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 0.25)
            ])
            
            // Telephoto camera button layout
            NSLayoutConstraint.activate([
                self.telephotoCameraButton.topAnchor.constraint(equalTo: self.buttonsView.topAnchor),
                self.telephotoCameraButton.bottomAnchor.constraint(equalTo: self.buttonsView.bottomAnchor),
                self.telephotoCameraButton.leadingAnchor.constraint(equalTo: self.ultraWideCameraButton.trailingAnchor),
                self.telephotoCameraButton.widthAnchor.constraint(equalTo: self.buttonsView.widthAnchor, multiplier: 0.25)
            ])
        }
    }
}

// MARK: - Methods add
extension ViewController {
    enum CameraType {
        case single
        case dual(eleven: Bool)
        case triple
    }
    
    // Determine camera type
    func determineCameraType() -> CameraType {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInDualWideCamera, .builtInTelephotoCamera, .builtInTelephotoCamera, .builtInTripleCamera, .builtInTrueDepthCamera, .builtInUltraWideCamera, .builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        
        let supportedDevices = discoverySession.devices
        
        if self.captureDeviceTypes.isEmpty {
            for device in supportedDevices {
                self.captureDeviceTypes.append(device.deviceType)
            }
        }
        
        if self.captureDeviceTypes.contains(.builtInTripleCamera) {
            return .triple
            
        } else if self.captureDeviceTypes.contains(.builtInDualCamera) {
            if self.captureDeviceTypes.contains(.builtInUltraWideCamera) {
                return .dual(eleven: true)
                
            } else {
                return .dual(eleven: false)
            }
            
        } else {
            return .single
        }
    }
    
    // Initialize camera
    func initializeCamera() {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera , for: .video, position: .back) else {
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                
                self.wideCameraButton.isSelected = true
                
            } else {
                print("Not supported")
            }

        } catch let error {
            print("Error: " + error.localizedDescription)
        }

        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer!.videoGravity = .resizeAspectFill
        self.previewLayer!.connection?.videoOrientation = .portrait

        self.previewLayer!.frame = self.cameraView.bounds
        self.cameraView.layer.addSublayer(self.previewLayer!)

        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
        
        self.determineOrientation()
    }
    
    // Camera output orientation determination
    func determineOrientation() {
        if let connection = self.previewLayer?.connection {
            if let currentOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
                switch currentOrientation {
                case .landscapeLeft:
                    connection.videoOrientation = .landscapeLeft
                    
                case .landscapeRight:
                    connection.videoOrientation = .landscapeRight
                    
                case .portrait:
                    connection.videoOrientation = .portrait
                    
                case .portraitUpsideDown:
                    connection.videoOrientation = .portraitUpsideDown
                
                case .unknown:
                    connection.videoOrientation = .portrait
                    
                @unknown default:
                    fatalError()
                }
            }
        }
        
        self.previewLayer?.frame = self.cameraView.bounds
        
        // FIXME: Need to search about outputs from AVCaptuerSession.
//        let outputs = self.captureSession.outputs
//        print("Outputs::: \(outputs)")
//
//        for output in outputs {
//            if let connection = output.connection(with: .video) {
//                if let currentOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
//                    switch currentOrientation {
//                    case .landscapeLeft:
//                        connection.videoOrientation = .landscapeLeft
//
//                    case .landscapeRight:
//                        connection.videoOrientation = .landscapeRight
//
//                    case .portrait:
//                        connection.videoOrientation = .portrait
//
//                    case .portraitUpsideDown:
//                        connection.videoOrientation = .portraitUpsideDown
//
//                    case .unknown:
//                        connection.videoOrientation = .portrait
//
//                    @unknown default:
//                        fatalError()
//                    }
//                }
//            }
//        }
    }
}

// MARK: - Objc methods added
extension ViewController {
    @objc func frontCameraButton(_ sender: UIButton) {
        guard !self.frontCameraButton.isSelected else {
            return
        }
        
        self.frontCameraButton.isSelected = true
        self.wideCameraButton.isSelected = false
        self.ultraWideCameraButton.isSelected = false
        self.telephotoCameraButton.isSelected = false
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            return
        }
        
        self.captureSession.beginConfiguration()
        
        do {
            if let currentInput = self.captureSession.inputs.first {
                self.captureSession.removeInput(currentInput)
                
            } else {
                return
            }
            
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                
            } else {
                print("Not supported")
                
                return
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.captureSession.commitConfiguration()
    }
    
    @objc func wideCameraButton(_ sender: UIButton) {
        guard !self.wideCameraButton.isSelected else {
            return
        }
        
        self.frontCameraButton.isSelected = false
        self.wideCameraButton.isSelected = true
        self.ultraWideCameraButton.isSelected = false
        self.telephotoCameraButton.isSelected = false
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        
        self.captureSession.beginConfiguration()
        
        do {
            if let currentInput = self.captureSession.inputs.first {
                self.captureSession.removeInput(currentInput)
                
            } else {
                return
            }
            
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                
            } else {
                print("Not supported")
                
                return
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.captureSession.commitConfiguration()
    }
    
    @objc func ultraWideCameraButton(_ sender: UIButton) {
        guard !self.ultraWideCameraButton.isSelected else {
            return
        }
        
        self.frontCameraButton.isSelected = false
        self.wideCameraButton.isSelected = false
        self.ultraWideCameraButton.isSelected = true
        self.telephotoCameraButton.isSelected = false
        
        guard let camera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) else {
            return
        }
        
        self.captureSession.beginConfiguration()
        
        do {
            if let currentInput = self.captureSession.inputs.first {
                self.captureSession.removeInput(currentInput)
                
            } else {
                return
            }
            
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                
            } else {
                print("Not supported")
                
                return
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.captureSession.commitConfiguration()
    }
    
    @objc func telephotoCameraButton(_ sender: UIButton) {
        guard !self.telephotoCameraButton.isSelected else {
            return
        }
        
        self.frontCameraButton.isSelected = false
        self.wideCameraButton.isSelected = false
        self.ultraWideCameraButton.isSelected = false
        self.telephotoCameraButton.isSelected = true
        
        guard let camera = AVCaptureDevice.default(.builtInTelephotoCamera, for: .video, position: .back) else {
            return
        }
        
        self.captureSession.beginConfiguration()
        
        do {
            if let currentInput = self.captureSession.inputs.first {
                self.captureSession.removeInput(currentInput)
                
            } else {
                return
            }
            
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
                
            } else {
                print("Not supported")
                
                return
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.captureSession.commitConfiguration()
    }
    
    @objc func didEnterBackground(_ notification: Notification) {
        if self.captureSession.isRunning {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    @objc func willEnterForeground(_ notification: Notification) {
        guard !self.captureSession.isRunning else {
            return
        }
        
        DispatchQueue.global().async {
             self.captureSession.startRunning()
        }
        
    }
    
    @objc func sessionRuntimeError(_ notification: Notification) {
        print("AVCapture Session Runtiem Error")
    }
}

// MARK: - Utility methods
extension ViewController {
    // MARK: Add Subviews
    func addSubviews(_ views: [UIView], to: UIView) {
        for view in views {
            to.addSubview(view)
        }
    }
}

