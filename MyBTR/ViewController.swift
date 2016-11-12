//
//  ViewController.swift
//  MyBTR
//
//  Created by AARON on 11/12/16.
//  Copyright © 2016 AARON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!
    
    @IBOutlet weak var ledToggleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self)
    }
    
    @IBAction func ledToggleButtonDown(sender: UIButton) {
        simpleBluetoothIO.writeValue(value: 1)
    }
    
    @IBAction func ledToggleButtonUp(sender: UIButton) {
        simpleBluetoothIO.writeValue(value: 0)
    }
    
}

extension ViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        if value > 0 {
            view.backgroundColor = UIColor.yellow
        } else {
            view.backgroundColor = UIColor.black
        }
    }
}

