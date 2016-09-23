//
//  KQNetwork.swift
//  DidomOnline
//
//  Created by QuocKhai on 4/28/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

var iNetwork: Reachability!
var iCheckNetwork: Bool = false
var iWifiReachable: Bool = false
var iCellularReachable: Bool = false

class KQNetwork: NSObject {
    //MARK: Listen network
    class func reachNetwork() -> Reachability {
        return iNetwork
    }
    
    class func listenNetwork() {
        // -- Listen network
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            KQNetwork.reachableNetwork()
        }
    }
    
    class func reachableNetwork() {
//        iNetwork = Reachability(hostname: "www.google.com")
//        
//        
//        iNetwork.reachableBlock = {(reachability) in
//            dispatch_async(dispatch_get_main_queue()){
//                NSLog("Network is reachable")
//                KQNetwork.setCheckNetworkDone(true)
//            }
//        }
//        
//        iNetwork.unreachableBlock = {(reachability) in
//            dispatch_async(dispatch_get_main_queue()){
//                NSLog("Network isn't reachable")
//                KQNetwork.setCheckNetworkDone(true)
//            }
//        }
//        
//        iNetwork.startNotifier()
        
//        let reachability: Reachability
        
        do {
            iNetwork = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("[Network]: Unable to create Reachability!!!")
            return
        }
        
        iNetwork.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                print("[Network]: Network reachable!")
                KQNetwork.setCheckNetworkDone(true)
                
                if reachability.isReachableViaWiFi() {
                    KQNetwork.setWifiReachable(true)
                } else {
                    KQNetwork.setCellularReachable(true)
                }
            }
        }
        
        iNetwork.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                print("[Network]: Network not reachable")
                KQNetwork.setCheckNetworkDone(true)
                
                KQNetwork.setWifiReachable(false)
                KQNetwork.setCellularReachable(false)
            }
        }
        
        do {
            try iNetwork.startNotifier()
        } catch {
            print("[Network]: Unable to start notifier!!!")
        }
    }
    
    
    //MARK: Show notification
    class func networkNotification() {
        //declare this property where it won't go out of scope relative to your listener
//        var reachability: Reachability?
        
        //declare this inside of viewWillAppear
        do {
            iNetwork = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("[Network]: Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KQNetwork.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: iNetwork)
        do{
            try iNetwork?.startNotifier()
        }catch{
            print("[Network]: Could not start reachability notifier")
        }
    }
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("[Network]: Reachable via WiFi")
            } else {
                print("[Network]: Reachable via Cellular")
            }
        } else {
            print("[Network]: Network not reachable")
        }
    }
    
    //MARK: Stop reachability
    class func stopNotifier() {
        iNetwork.stopNotifier()

    }
    
    class func stopNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: iNetwork)
    }

    //MARK: Set check network done or not
    class func checkNetworkDone() -> Bool {
        return iCheckNetwork
    }
    
    class func setCheckNetworkDone(temp: Bool) {
        iCheckNetwork = temp
    }
    
    
    //MARK: Network reachable via Wifi or Cellular?
    class func setWifiReachable(temp: Bool){
        iWifiReachable = temp
    }
    
    class func WifiReachable() -> Bool {
        return iWifiReachable
    }
    
    class func setCellularReachable(temp: Bool) {
        iCellularReachable = temp
    }
    
    class func CellularReachable() -> Bool {
        return iCellularReachable
    }
    
    class func waitForNetworkAvaible(completionHandler: () -> Void) {
        var countTime = 0
        
        while !KQNetwork.reachNetwork().isReachable() {
            sleep(1)
            countTime = countTime + 1
            
            print("[Network]: Count time: \(countTime)")
            if countTime == 10 {
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    KQData.showToast("Réseau non disponible!")
                }
                
                countTime = 0
            }
            
//            if countTime == TIME_BREAK {
//                print("[Network]: Break - waitForNetworkAvaible")
//                break
//            }
            
            if KQNetwork.reachNetwork().isReachable() {
                completionHandler()
            }
        }
    }
}
