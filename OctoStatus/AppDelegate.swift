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
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var menu:NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let bar = NSStatusBar.systemStatusBar()
        statusItem = bar.statusItemWithLength(CGFloat(-1))
        menu = NSMenu()
        statusItem!.title = ""
        statusItem!.menu = menu
        statusItem!.highlightMode = true
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

