//
//  KQNotification.swift
//  DidomOnline
//
//  Created by QuocKhai on 5/1/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//



import UIKit

class KQNotification: NSObject {

    class func localNotification() {
//        print("Number of local notification: \(UIApplication.sharedApplication().scheduledLocalNotifications?.count)")
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        print("[KQNotification]: Cancell All Local Notification!")
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.setListNotifications()
        }
    }
    
    class func setListNotifications() {

        let timeNotif = 600
        
        let numberOfNotifications = 64
        
        for index in 0 ..< numberOfNotifications {
            let timeNotification = Int(60 * (index + 1))
//            let timeNotification = Int(timeNotif * 60 * (index + 1))
            
            //🐖 🐄 🐓 🐕 🐀 🐇 🐳 🐉
            let notificationMessage = "Cảnh báo: Website của bạn vừa bị phát hiện thêm một lỗi mới!"
            
            LocalNotificationHelper.sharedInstance().scheduleNotificationWithKey("\(index)", title: "DSmart", message: notificationMessage, seconds: Double(timeNotification), userInfo: ["title": "DSmart", "message": "\(notificationMessage)", "index": "\(index)"])
        }
        
        print("[KQNotification]: Set Local Notification!")
    }
 
}
