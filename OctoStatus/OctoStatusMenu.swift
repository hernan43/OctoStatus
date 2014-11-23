//
//  OctoStatusMenu.swift
//  OctoStatus
//
//  Created by Ramon Hernandez on 11/22/14.
//  Copyright (c) 2014 Shaclack. All rights reserved.
//

import Cocoa

class OctoStatusMenu: NSMenu {
    
    @IBOutlet weak var settingsItem: NSMenuItem!
    @IBOutlet weak var quitItem: NSMenuItem!
    
    lazy var settingsController = SettingsController(windowNibName: "SettingsController")
    // will use this to poll OctoPrint via the client
    var jobStatusTimer: NSTimer?
    
    override init(title aTitle: String){
        super.init(title: aTitle)
        startPolling()
        setupItems()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startPolling()
        setupItems()
    }
    
    func setupItems(){
    
    }
    
    func startPolling(){
        jobStatusTimer = NSTimer.scheduledTimerWithTimeInterval(
            5.0,
            target: self,
            selector: "checkJobStatus",
            userInfo: nil,
            repeats: true)
    }
    
    func checkJobStatus(){
        println("checkJobStatus called....")
    }
    
    @IBAction func settingsClicked(sender: AnyObject) {
        settingsController.showWindow(nil)
    }
    
    @IBAction func quitClicked(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }

}
