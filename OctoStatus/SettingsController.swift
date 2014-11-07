//
//  SettingsController.swift
//  OctoStatus
//
//  Created by Ramon Hernandez on 11/6/14.
//  Copyright (c) 2014 Shaclack. All rights reserved.
//

import Cocoa

class SettingsController: NSWindowController {

    @IBOutlet weak var urlField: NSTextField!
    @IBOutlet weak var tokenField: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func okClicked(sender: AnyObject) {
        // do stuff
        
        // then
        window?.close()
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        window?.close()
    }
    
}
