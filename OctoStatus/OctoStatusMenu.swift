//
//  OctoStatusMenu.swift
//  OctoStatus
//
//  Created by Ramon Hernandez on 11/22/14.
//  Copyright (c) 2014 Shaclack. All rights reserved.
//

import Cocoa

class OctoStatusMenu: NSMenu, NSMenuDelegate {
    @IBOutlet weak var settingsItem: NSMenuItem!
    @IBOutlet weak var quitItem: NSMenuItem!
    
    lazy var settingsController = SettingsController(windowNibName: "SettingsController")


    @IBAction func settingsClicked(sender: AnyObject) {
        CredentialStore.getAPIURL()
        
        settingsController.showWindow(nil)
    }
    
    @IBAction func quitClicked(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }

}
