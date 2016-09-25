//
//  KQConfigure.swift
//  DidomOnline
//
//  Created by QuocKhai on 4/28/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

internal let APP_CFG = [CFG_COLOR_RAND, CFG_FIRT_RUN, CFG_FONT_NAME, CFG_RATE_APPS, CFG_DATE_BEACON, CFG_DEVICE_ID, CFG_USER_REGISTED, CFG_DATE_CALENDAR, CFG_WEB_LINK]

var iDictConfig: NSMutableDictionary!


class KQConfigure: NSObject {

    //MARK: Init config file
    class func initDefaultDictConfig() -> NSMutableDictionary {
        let dictConfig: NSMutableDictionary = NSMutableDictionary()
        
        dictConfig.setObject("0", forKey: CFG_FIRT_RUN)
        dictConfig.setObject("0", forKey: CFG_COLOR_RAND)
        dictConfig.setObject("Helvetica", forKey: CFG_FONT_NAME)
       
        dictConfig.setObject("0", forKey: CFG_RATE_APPS)
        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_BEACON)
        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_CALENDAR)
        dictConfig.setObject("nil", forKey: CFG_DEVICE_ID)
        dictConfig.setObject("0", forKey: CFG_USER_REGISTED)
        dictConfig.setObject("nil", forKey: CFG_WEB_LINK)
        
//        dictConfig.setObject("nil", forKey: CFG_TOKEN_APP)
//        dictConfig.setObject("nil", forKey: CFG_TOKEN_USER)
//
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_TOKEN_APP_TIME)
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_TOKEN_USER_TIME)
//        dictConfig.setObject("-1", forKey: CFG_TOKEN_APP_EXPIRES)
//        dictConfig.setObject("-1", forKey: CFG_TOKEN_USER_EXPIRES)
        
        
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_PAGE)
        
        return dictConfig;
    }
    
    //MARK: Default configue key value
    class func defaultKeyConfigValue(temp: String) -> String {
        let dictConfig: NSMutableDictionary = NSMutableDictionary()
        
        dictConfig.setObject("0", forKey: CFG_FIRT_RUN)
        dictConfig.setObject("0", forKey: CFG_COLOR_RAND)
        dictConfig.setObject("Helvetica", forKey: CFG_FONT_NAME)
       
        dictConfig.setObject("0", forKey: CFG_RATE_APPS)
        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_BEACON)
        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_CALENDAR)
        
        dictConfig.setObject("nil", forKey: CFG_DEVICE_ID)
        dictConfig.setObject("0", forKey: CFG_USER_REGISTED)
        dictConfig.setObject("nil", forKey: CFG_WEB_LINK)
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_DATE_PAGE)
        
//        dictConfig.setObject("nil", forKey: CFG_TOKEN_APP)
//        dictConfig.setObject("nil", forKey: CFG_TOKEN_USER)
//        
//        
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_TOKEN_APP_TIME)
//        dictConfig.setObject("2016-05-30 10:45:53", forKey: CFG_TOKEN_USER_TIME)
//        dictConfig.setObject("-1", forKey: CFG_TOKEN_APP_EXPIRES)
//        dictConfig.setObject("-1", forKey: CFG_TOKEN_USER_EXPIRES)
        
        return dictConfig.objectForKey(temp) as! String
    }
    
    
    class func DictConfig() -> NSMutableDictionary {
        return iDictConfig
    }
    
    class func setDictConfig() {
        iDictConfig = NSMutableDictionary(dictionary: KQFileHandle.readConfigure()!)
    }
    
    //MARK: Set configure info
    class func getConfigInfor(){
        
        if !KQFileHandle.fileNameExisted(FILE_CONFIG, fileType: FILE_TYPE) {
            var dictConfig: NSMutableDictionary = NSMutableDictionary()
            dictConfig = KQConfigure.initDefaultDictConfig()
            KQFileHandle.writeConfigure(dictConfig)
            
            KQConfigure.setDictConfig()
            
        }else {            
            KQConfigure.setDictConfig()
            
            KQConfigure.checkNewKey()
        }
    }
    
    class func checkNewKey() {
        var hasNewKey: Bool = false
        for key in APP_CFG {
            if KQConfigure.DictConfig()[key] == nil {
                // Check Default Value
                let valueOfKey: String = KQConfigure.defaultKeyConfigValue(key)
                
                // Add Key
                KQConfigure.DictConfig().setObject(valueOfKey, forKey: key)
                hasNewKey = true
            }
        }
        
        if hasNewKey {
            KQFileHandle.writeConfigure(KQConfigure.DictConfig())
        }
    }
}
