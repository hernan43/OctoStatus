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
import Alamofire

class OctoPrintClient {
    
    var url: String
    var token: String
    let manager: Alamofire.Manager
    
    class var sharedInstance : OctoPrintClient {
        struct Static {
            static let instance : OctoPrintClient = OctoPrintClient()
        }
        return Static.instance
    }
    
    init(){
        url = CredentialStore.getAPIURL()!
        token = CredentialStore.getAPIToken()!
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        manager = Alamofire.Manager(configuration: configuration)
    }
    
    class func regrabCredentials(){
        sharedInstance.url = CredentialStore.getAPIURL()!
        sharedInstance.token = CredentialStore.getAPIToken()!
    }
    
    func jobStatus() {
        var request = Alamofire.request(Router.JobStatus).responseJSON { (_, _, JSON, _) in
            // do something useful with the JSON
            // println(JSON)
        }
    }
}

enum Router: URLRequestConvertible {
    static var baseURLString: String { return OctoPrintClient.sharedInstance.url }
    static var APIToken: String { return OctoPrintClient.sharedInstance.token }
    
    case JobStatus
    
    var method: Alamofire.Method {
        switch self {
        case .JobStatus:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .JobStatus:
                return "/api/job"
            default:
                return "/"
        }
    }
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue(Router.APIToken, forHTTPHeaderField: "X-Api-Key")
        
        switch self {
            default:
                return mutableURLRequest
        }
    }
}