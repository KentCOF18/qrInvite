//
//  adminViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/9/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import AVFoundation

class adminViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        if let captureDevice = captureDevice {
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
           
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39]
            captureSession.startRunning()
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = cameraView.layer.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)
        } catch {
            print(error)
        }
        }
        
        
        //captureSession?.startRunning()

        // Do any additional setup after loading the view.
    }
    var count = 0
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("No Input Detected")
            count = count + 1
            let countString = String(count)
            counterLabel.text = countString
            return
        }
        
        let codeFrame:UIView = {
            let codeFrame = UIView()
            codeFrame.layer.borderColor = UIColor.green.cgColor
            codeFrame.layer.borderWidth = 2
            codeFrame.frame = CGRect.zero
            codeFrame.translatesAutoresizingMaskIntoConstraints = false
            return codeFrame
        }()
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        // Create some label and assign returned string value to it
        infoLabel.text = stringCodeValue
        // Perform further logic needed (ex. redirect to other ViewController)
        
    }


}
