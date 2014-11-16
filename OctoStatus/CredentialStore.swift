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

import Foundation

class CredentialStore {
    
    // workaround for lack of class variables
    class func serviceName() -> String {
        return "com.github.hernan43.octostatus"
    }
    
    class func urlKey() -> String {
        return "api_url"
    }
    
    class func getAPIURL() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey(CredentialStore.urlKey()) as? String
    }
    
    class func getAPIToken() -> String? {
        
        if let account = CredentialStore.getAPIURL() {
            return SSKeychain.passwordForService(CredentialStore.serviceName(), account: account)
        }
        
        return nil
    }
    
    class func setAPIURL(url: String) {
        NSUserDefaults.standardUserDefaults().setValue(url, forKey: CredentialStore.urlKey())
    }
    
    class func setAPIToken(token: String) -> Bool {
        if let account = CredentialStore.getAPIURL() {
            return SSKeychain.setPassword(token, forService: CredentialStore.serviceName(), account: CredentialStore.getAPIURL())
        }
        
        return false
    }

}