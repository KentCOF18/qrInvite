//
//  adminViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/9/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

// Left off trying to figure out how to store the array of names
// Need to then send that array to the listView
// Iterate through the array in list VC and display one element per cell

import UIKit
import AVFoundation
import MessageUI

class adminViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, MFMessageComposeViewControllerDelegate {
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
    var i = 0
    var guest = [String]()
    var count = 0
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("No Input Detected")
            count = count + 1
            if(count % 10 == 0) {
                sendCountMessage(total: count)
            }
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
        //adds
        
        guest.append(stringCodeValue)
        
        
        // Create some label and assign returned string value to it
        let name = stringCodeValue.components(separatedBy: ":")
        let subStr = String(name[1].dropLast(6))
        infoLabel.text = subStr
    }
    
    func sendCountMessage(total: Int) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "\(total) people have signed in\(guest[0])";
        messageVC.recipients = ["+16147257253"]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
            break;
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
            break;
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
            break;
        }
    }
    
    func returnGuest() -> [String] {
        print("Return guest called\(guest.count)")
        return guest
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! checkedInListViewController
        destVC.guest = guest
    }


}
