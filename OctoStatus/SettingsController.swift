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

class SettingsController: NSWindowController {

    var url: String?
    var token: String?
    
    @IBOutlet weak var urlField: NSTextField!
    @IBOutlet weak var tokenField: NSTextField!
    
    override func windowDidLoad() {
        // set textField values
        urlField.stringValue = CredentialStore.getAPIURL()!
        tokenField.stringValue = CredentialStore.getAPIToken()!
        
        super.windowDidLoad()
    }
    
    @IBAction func okClicked(sender: AnyObject) {
        // do stuff
        CredentialStore.setCredentials(urlField.stringValue, token: tokenField.stringValue)

        window?.close()
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        window?.close()
    }
    
}
