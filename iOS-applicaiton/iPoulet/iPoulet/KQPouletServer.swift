//
//  KQPouletServer.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class KQPouletServer: NSObject {

    class func getLogFile(webLink: String,completionHandler: (error: NSError?, data: NSData?) -> Void) {
        
        
        //        Alamofire.request(.GET, GET_BEACONS_LOCATION, parameters: ["format":"json"]).responseData { response in
        //            let decodedString = NSString(data: response.result.value!, encoding: NSUTF8StringEncoding)
        //            print(decodedString!)
        //        }
        
        let requestString = LOG_GET.stringByReplacingOccurrencesOfString("{webname}", withString: webLink)
        
        Alamofire.request(.GET, requestString, parameters: ["format":"json"]).responseData { (response) in
            
//            let decodedString = NSString(data: response.result.value!, encoding: NSUTF8StringEncoding)
//            print(decodedString!)
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    completionHandler(error: nil, data: value)
                } else {
                    completionHandler(error: nil, data: nil)
                }
                
                break
                
            case .Failure(let error):
                completionHandler(error: error, data: nil)
                break
            }
        }
    }

    
}
