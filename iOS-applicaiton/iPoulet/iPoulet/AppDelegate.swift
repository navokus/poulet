//
//  AppDelegate.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        KQFileHandle.setEncrypted(true)
        
        print("Documents link: \(kDocuments)")
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad{
            KQData.setIsIPad(true)
        }
        else{
            KQData.setIsIPad(false)
        }
        
        // -- Network & Configure
        KQConfigure.getConfigInfor()
        KQNetwork.listenNetwork()
        
        
        self.getListErrorFromFile()
        
        // Time idle & Notification
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil))
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        KQSize.setWidth(screenSize.width)
        KQSize.setHeight(screenSize.height)
        
        let randomIndex: UInt32 = (arc4random()) % 6
        KQData.setColorIndex(randomIndex)
        
        
        self.setRootViewController()
        
        return true
    }
    
    func setRootViewController() {
        // -- Set root view
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController =  KQTabBarController.TabBarController()
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = BG_COLOR
        KQData.setRootView((self.window?.rootViewController)!)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func getListErrorFromFile() {
        KQData.setListError(NSMutableArray())
        
        let jsonPath = NSBundle.mainBundle().pathForResource("listError", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonPath!)
        
        let json = JSON(data: jsonData!)
        
        let listBeacon = NSMutableArray()
        
        for (_, beacon):(String, JSON) in json {
            let iBeacon = KQSolution()
            iBeacon.id = beacon["id"].stringValue
            iBeacon.title = beacon["title"].stringValue
            iBeacon.type = beacon["type"].stringValue
            
            listBeacon.addObject(iBeacon)
        }
        
        KQData.setListError(listBeacon)
    }

}

