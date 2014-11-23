//
// OctoStatus is a status bar widget for OS X that gives feedback on 
// what OctoPrint is doing.
// Copyright (C) 2014  Ray Hernandez
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem:NSStatusItem?
    lazy var client = OctoPrintClient.sharedInstance
    var updateStatusbarTimer: NSTimer?
    
    @IBOutlet var menu: OctoStatusMenu!

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
        
        updateStatusbarTimer = NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: "updateStatusbar",
            userInfo: nil,
            repeats: true)
    }
    
    func updateStatusbar() {
        if let status = (statusItem?.menu? as? OctoStatusMenu)?.getJobStatus() {
            switch status {
                default:
                    statusItem?.title = status
            }
        } else {
            statusItem?.title = ""
        }
    }
}

