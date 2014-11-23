//
//  OctoStatusMenu.swift
//  OctoStatus
//
//  Created by Ramon Hernandez on 11/22/14.
//  Copyright (c) 2014 Shaclack. All rights reserved.
//

import Cocoa

class OctoStatusMenu: NSMenu {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var jobStatusItem: NSMenuItem!
    @IBOutlet weak var filenameItem: NSMenuItem!
    @IBOutlet weak var timeRemainingItem: NSMenuItem!
    @IBOutlet weak var settingsItem: NSMenuItem!
    @IBOutlet weak var quitItem: NSMenuItem!
    
    // MARK: Class and instance variables 
    
    lazy var settingsController = SettingsController(windowNibName: "SettingsController")
    // will use this to poll OctoPrint via the client
    var jobStatusTimer: NSTimer?
    
    // MARK: Required functions
    
    override init(title aTitle: String){
        super.init(title: aTitle)
        startPolling()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startPolling()
    }
    
    // MARK: Public functions
    func getJobStatus() -> String {
        return jobStatusItem.title
    }
    
    func checkJobStatus(){
        OctoPrintClient.sharedInstance.jobStatus().responseJSON { (_, _, JSON, _) in
            if let json: AnyObject = JSON? {
                self.processJSONResponse(json)
            }
        }
    }

    func goOffline(){
        // hide everything but the status
        jobStatusItem.hidden = false
        filenameItem.hidden = true
        timeRemainingItem.hidden = true
    }
    
    func processJSONResponse(json: AnyObject) {
        if let status = json["state"]? as? String {

            // set both the statusitem and menuitem
            jobStatusItem.title = status

            switch status {
                default:
                    goOffline()
            }
        }
    }
    
    func startPolling(){
        jobStatusTimer = NSTimer.scheduledTimerWithTimeInterval(
            5.0,
            target: self,
            selector: "checkJobStatus",
            userInfo: nil,
            repeats: true)
    }
    
    // MARK: IBActions
    
    @IBAction func settingsClicked(sender: AnyObject) {
        if let window = settingsController.window? {
            window.center()
            window.makeKeyAndOrderFront(window)
        }
    }
    
    @IBAction func quitClicked(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }

}
