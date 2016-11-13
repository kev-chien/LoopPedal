//
//  ViewController.swift
//  Audio2016
//
//  Created by AARON on 11/12/16.
//  Copyright © 2016 AARON. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    let recorder = AudioRecorder!
    var recording = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let oscillator = AKOscillator()
        oscillator.amplitude = 0.1
        AudioKit.output = oscillator
        AudioKit.start()
        
        oscillator.start()
        
        let documentDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let recordingAudioFilePath = NSURL(string: documentDirPath)!.appendingPathComponent("recording.caf")?.path
        let recordingAudioFileURL = NSURL(fileURLWithPath: recordingAudioFilePath!)
        recorder = AKAudioRecorder(recordingAudioFileURL.absoluteString)
        
    }

    
    @IBAction func RecordButton(_ sender: UIButton) {
        if recording == true {
            print("Recording stopped")
            recording = false
            recorder.stop()
        } else {
            print("Recording started")
            recording = true
            recorder.record()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

