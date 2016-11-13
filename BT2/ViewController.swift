//
//  ViewController.swift
//  BT2
//
//  Created by AARON on 11/12/16.
//  Copyright © 2016 AARON. All rights reserved.
//

import Cocoa
import IOBluetooth

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

class Bluetoothget {
    func openConnection(_ target: Any!, withPageTimeout pageTimeoutValue: BluetoothHCIPageTimeout, authenticationRequired: Bool) -> IOReturn{
        return target as! IOReturn
    }
}



