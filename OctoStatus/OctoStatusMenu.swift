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
                //println(json)
                self.processJSONResponse(json)
            }
        }
    }

    func setMenuItems(json: AnyObject){
        setFilename(json)

        // hide everything but the status
        jobStatusItem.hidden = false
        timeRemainingItem.hidden = true
    }
    
    func setFilename(json: AnyObject){
        // default state
        filenameItem.hidden = true

        // set active filename, if loaded
        if let filename = json.valueForKeyPath("job.file.name") as? String {
            filenameItem.title = "file: \(filename)"
            // show filename if file is loaded
            filenameItem.hidden = false
        }

    }
    
    func processJSONResponse(json: AnyObject) {
        if let status = json["state"]? as? String {

            // set both the statusitem and menuitem
            jobStatusItem.title = status.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            /*
            List of states I could find in the OctoPrint source
            
            Offline
            Opening serial port
            Detecting serial port
            Detecting baudrate
            Connecting
            Operational
            Printing from SD
            Sending file to SD
            Printing
            Paused
            Closed
            Error: %s
            Transfering file to SD
            
            */
            switch status {
                default:
                    setMenuItems(json)
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
