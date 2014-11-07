//
//  AppDelegate.swift
//  OctoStatus
//
//  Created by Ramon Hernandez on 11/3/14.
//  Copyright (c) 2014 Shaclack. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem:NSStatusItem?
    lazy var settingsController = SettingsController(windowNibName: "SettingsController")
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet var menu: NSMenu!
    @IBOutlet weak var settingsItem: NSMenuItem!
    @IBOutlet weak var quitItem: NSMenuItem!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    override func awakeFromNib() {
        let bar = NSStatusBar.systemStatusBar()
        statusItem = bar.statusItemWithLength(CGFloat(-1))
        
        statusItem!.title = ""
        statusItem!.menu = self.menu
        statusItem!.highlightMode = true
        statusItem!.image = NSImage(named:"tentacle")
    }
    
    @IBAction func settingsClicked(sender: AnyObject) {
        settingsController.showWindow(nil)
    }
    
    @IBAction func quitClicked(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
}

