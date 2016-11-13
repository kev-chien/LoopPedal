//
//  ViewController.swift
//  BPMMac
//
//  Created by Kelly Huang on 11/12/16.
//  Copyright © 2016 Kelly Huang. All rights reserved.
//

import Cocoa
//MARK: Properties

//timer
var time = 0
var timetimer = Timer()
var boo = 0

//save BPM
var saveBPM1 = 0
var saveBPM2 = 0
var saveBP
  M3 = 0
var averageBPM = 0
class ViewController: NSViewController {

@IBOutlet weak var BPMLabel: NSTextField!
@IBOutlet weak var numberBPM: NSTextField!
@IBOutlet weak var timeLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func BPMTaps(_ sender: NSButton) {
        BPMLabel.text = "Averaging Beat"
        timetimer.invalidate()
        timetimer = Timer.scheduledTimer(timeInterval: 0.01
            , target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
        boo += 1
        print(boo)
        
        if(boo==4){
            saveBPM3 = time
            print("4", time)
            timetimer.invalidate()
            time = 0
            timeLabel.text = ("Done")
            averageBPM = (saveBPM1+saveBPM2+saveBPM3)/3
            boo = 0
            //AverageBPMLabel.text = "Play Beat"
            print("av", averageBPM)
        }
        if(boo==2){
            saveBPM1 = time
            print("2", time)
        }
        if(boo==3){
            saveBPM2 = time
            print("3", time)
        }
        time = 0
    }
    
    func action()
    {
        time+=1
        timeLabel.text = String(time)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

