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

var iManager: Alamofire.Manager!



class KQPouletServer: NSObject {
    
    class func configManager() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 24.0*60.0*60.0
        configuration.timeoutIntervalForResource = 24.0*60.0*60.0
        iManager = Alamofire.Manager(configuration: configuration)
    }

    class func getErrorStatic(webLink: String,completionHandler: (error: NSError?, data: NSData?) -> Void) {
        
        
        //        Alamofire.request(.GET, GET_BEACONS_LOCATION, parameters: ["format":"json"]).responseData { response in
        //            let decodedString = NSString(data: response.result.value!, encoding: NSUTF8StringEncoding)
        //            print(decodedString!)
        //        }
        
        let requestString = ERROR_STATIC.stringByReplacingOccurrencesOfString("{webname}", withString: webLink)
        
        
        
        iManager.request(.GET, requestString, parameters: ["format":"json"]).responseData { (response) in
            
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
    
    class func getLogContent(webLink: String,completionHandler: (error: NSError?, data: NSData?) -> Void) {
        
        let requestString = LOG_GET.stringByReplacingOccurrencesOfString("{webname}", withString: webLink)
        
        iManager.request(.GET, requestString, parameters: ["format":"json"]).responseData { (response) in
            
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
