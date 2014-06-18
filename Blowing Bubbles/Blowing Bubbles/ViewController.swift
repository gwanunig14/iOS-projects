//
//  ViewController.swift
//  Blowing Bubbles
//
//  Created by T.J. Mercer on 6/18/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

import UIKit

import AVFoundation

import CoreMedia

class ViewController: UIViewController,AVCaptureAudioDataOutputSampleBufferDelegate {
    
    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(128000, error: nil)
        
        var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        var audioCaptureInput = AVCaptureDeviceInput(device: device, error: nil)
        audioCaptureSession.addInput(audioCaptureInput)
        
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, CUnsignedLong(0)))
        audioCaptureSession.addOutput(audioDataOutput)
        audioCaptureSession.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!){
        for channel: AVCaptureAudioChannel! in connection.audioChannels {
            println("Power Level \(channel.averagePowerLevel)")
            
            if channel.averagePowerLevel > -20  {
                self.createBubble()
            }
            
        }
    }
    
    func createBubble ()
    {
        var randomsize = CGFloat(arc4random_uniform(40)+20)
        var bubble = UIView(frame:CGRectMake(160, 0, randomsize, randomsize))
        bubble.layer.borderColor = UIColor.blueColor().CGColor
        bubble.layer.borderWidth = 1.0
        bubble.layer.cornerRadius = randomsize/2.0
        
        self.view.addSubview(bubble)
        
        UIView.animateWithDuration(1.0, animations: {
            var randomX = CGFloat(arc4random_uniform(320))
            var randomY = CGFloat(arc4random_uniform(300)+300)
            
            bubble.frame = CGRectMake(randomX, randomY, randomsize, randomsize)
            
            }, completion: {finished in
                bubble.removeFromSuperview()
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

