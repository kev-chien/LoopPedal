
//
//  ViewController.swift
//  SimpleRecordingApp
//
//  Created by Loop Pedal on 11/12/16.
//  Copyright © 2016 Loop Pedal. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //audio player and recorder
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var metronomeLabel: UILabel!
    //@IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var bpmTapOutlet: UIButton!
    var first_recording = true
    
    
    //timer
    var time = 0
    var intervalTimer = Timer()
    //var metronomeTimer = Timer()
    //var metronomeTime = 0
    //var metronomeActivated = 0
    var intervalCount = 0
    
    //save BPM
    var saveBPM1 = 0
    var saveBPM2 = 0
    var saveBPM3 = 0
    var averageBPM = 0
    var actualBPM = 0
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var metAlpha = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isEnabled = false
        stopButton.isEnabled = false
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }


    @IBAction func recordAudio(_ sender: UIButton?) {
        if audioRecorder?.isRecording == false {
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }

    @IBAction func bpmTap(_ sender: Any) {
        intervalTimer.invalidate()
        intervalTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
        intervalCount += 1
        print(intervalCount)
        
        if(intervalCount==4){
            saveBPM3 = time
            print("4", time)
            intervalTimer.invalidate()
            time = 0
            //timerLabel.text = ("Done")
            averageBPM = (saveBPM1+saveBPM2+saveBPM3)/3
            intervalCount = 0
            //AverageBPMLabel.text = "Play Beat"
            print("av", averageBPM)
            actualBPM = 6000 / averageBPM
            metronomeLabel.text = "Metronome: \(actualBPM) bpm"
            bpmTapOutlet.setTitle("Tap to reset", for: UIControlState.normal)
            
            //activate metronome
            /*
            if metronomeActivated == 0{
                metronomeActivated = 1
                metronomeTimer.invalidate()
                metronomeTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.action2), userInfo: nil, repeats: true)
            }*/
        }
        if(intervalCount==1){
            bpmTapOutlet.setTitle("Beat 2", for: UIControlState.normal)
        }
        if(intervalCount==2){
            saveBPM1 = time
            print("2", time)
            bpmTapOutlet.setTitle("Beat 3", for: UIControlState.normal)
        }
        if(intervalCount==3){
            saveBPM2 = time
            print("3", time)
            bpmTapOutlet.setTitle("Beat 4", for: UIControlState.normal)
        }
        time = 0
    }
    
    @IBAction func stopAudio(_ sender: UIButton?) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
            playAudioFunc()
        } else {
            audioPlayer?.stop()
        }
    }
    
    
    @IBAction func playAudio(_ sender: UIButton?) {
        playAudioFunc()
    }
    
    func playAudioFunc(){
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.numberOfLoops = -1
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func action2()
    {
        //time += 1
        //metAlpha = CGFloat((cos(2.0 * 3.14 * time/ Double(averageBPM)) + 1.0)/2.0)
        //metronomeLabel.alpha = metAlpha
        //print(time)
    }
    
    func action()
    {
        time+=1
        //timerLabel.text = String(time)
        
    }

}

