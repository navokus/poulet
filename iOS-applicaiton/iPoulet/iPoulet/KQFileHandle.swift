//
//  KQFileHandle.swift
//  FileHandleOne
//
//  Created by QuocKhai on 6/3/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

internal let FILE_PASSWD = "DFD9FE84-B476-4639-9DFA-13D520B39A04"

internal let FILE_CONFIG = "KQConfigure"
internal let FILE_PAGE = "ListPage"
internal let FILE_RSS = "ListRSS"
internal let FILE_FAVORITE = "ListFavorite"
internal let FILE_USER = "ListUser"
internal let FILE_SALLE = "ListSalle"
internal let FILE_BEACON = "ListBeacon"
internal let FILE_CALENDAR = "ListCours"

//internal let FILE_JSON = "json"
//internal let FILE_XML = "xml"
internal let FILE_TYPE = "qk"

var kDocuments = "\(NSHomeDirectory())/Documents"
var iEncrypted: Bool!

class KQFileHandle: NSObject {

    class func fileNameExisted(fileName: String, fileType: String) -> Bool {
        let filePath = String(format: "%@/%@.%@", kDocuments, fileName, fileType)
        
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func filePathExisted(filePath: String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func filePathInDocuments(fileName: String, fileType: String) -> String {
        return String(format: "%@/%@.%@", kDocuments, fileName, fileType)
    }
    
    class func copyFileToDocuments(fileName: String, fileType: String) {
        let filePathInDocuments = String(format: "%@/%@.%@", kDocuments, fileName, fileType)
        if !KQFileHandle.fileNameExisted(fileName, fileType: fileType) {
            let filePathInBundle = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
            
            do {
                try NSFileManager.defaultManager().copyItemAtPath(filePathInBundle!, toPath: filePathInDocuments)
                
            } catch let error as NSError {
                print("[KQFileHandle]: Copy file failed with error: \(error)")
            }
        }
    }
    

    class func writeConfigure(dictConfigure: NSDictionary) {
        let filePath = KQFileHandle.filePathInDocuments(FILE_CONFIG, fileType: FILE_TYPE)
        
        
//        if !KQFileHandle.fileExisted(FILE_CONFIG, fileType: FILE_XML) {
//            KQFileHandle.createFileInDocuments(FILE_CONFIG, fileType: FILE_XML)
//        }
        
        if KQFileHandle.Encrypted() {
            var dataConfig = NSKeyedArchiver.archivedDataWithRootObject(dictConfigure)
            
            dataConfig = RNCryptor.encryptData(dataConfig, password: FILE_PASSWD)
            
            dataConfig.writeToFile(filePath, atomically: true)
        } else {
            dictConfigure.writeToFile(filePath, atomically: true)
        }
        
        if KQFileHandle.isSkipBackup(filePath) == false {
            if KQFileHandle.addSkipBackupAttributeToItemAtURL(filePath) == true {
                print("Skip Backup Data File!")
            } else {
                print("Skip Backup Failed!")
            }
        } else {
            print("File is Backed!")
        }
    }
    
    
    
    class func readConfigure() -> NSDictionary? {
        let filePath = KQFileHandle.filePathInDocuments(FILE_CONFIG, fileType: FILE_TYPE)
        
        if KQFileHandle.filePathExisted(filePath) {
            var dictConfig = NSDictionary()
            
            if KQFileHandle.Encrypted() {
                let dataEncrypted = NSData(contentsOfFile: filePath)
                
                do {
                    let dataConfig = try RNCryptor.decryptData(dataEncrypted!, password: FILE_PASSWD)
                    dictConfig = NSKeyedUnarchiver.unarchiveObjectWithData(dataConfig) as! NSDictionary
                    
                } catch let error as NSError {
                    print("[KQFileHandle]: Read config failed with error: \(error)")
                }
            } else {
                dictConfig = NSDictionary(contentsOfFile: filePath)!
            }
            
            return dictConfig
        } else {
            return nil
        }
    }
    
    
    class func write(data: NSData, fileName: String) {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        
//        if !KQFileHandle.fileExisted(fileName, fileType: FILE_TYPE) {
//            KQFileHandle.createFileInDocuments(fileName, fileType: FILE_TYPE)
//        }
        
        if KQFileHandle.Encrypted() {
            let encryptData = RNCryptor.encryptData(data, password: FILE_PASSWD)
            encryptData.writeToFile(filePath, atomically: true)
        } else {
            data.writeToFile(filePath, atomically: true)
        }
        
        if KQFileHandle.isSkipBackup(filePath) == false {
            if KQFileHandle.addSkipBackupAttributeToItemAtURL(filePath) == true {
                print("Skip Backup Data File!")
            } else {
                print("Skip Backup Failed!")
            }
        } else {
            print("File is Backed!")
        }
    }
    
    class func writeRSSArray(array: NSMutableArray, fileName: String) {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        let arrayToWrite = KQFileHandle.arrayToRSSDict(array)
        
        if KQFileHandle.Encrypted() {
            let dataArray = NSKeyedArchiver.archivedDataWithRootObject(arrayToWrite!)
            let dataEncrypt = RNCryptor.encryptData(dataArray, password: FILE_PASSWD)
            
            dataEncrypt.writeToFile(filePath, atomically: true)
        } else {
            arrayToWrite?.writeToFile(filePath, atomically: true)
        }
        
        if KQFileHandle.isSkipBackup(filePath) == false {
            if KQFileHandle.addSkipBackupAttributeToItemAtURL(filePath) == true {
                print("Skip Backup Data File!")
            } else {
                print("Skip Backup Failed!")
            }
        } else {
            print("File is Backed!")
        }
    }
    
    class func writePageArray(array: NSMutableArray, fileName: String) {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        let arrayToWrite = KQFileHandle.arrayToPageDictionary(array)
        
        if KQFileHandle.Encrypted() {
            let dataArray = NSKeyedArchiver.archivedDataWithRootObject(arrayToWrite!)
            let dataEncrypt = RNCryptor.encryptData(dataArray, password: FILE_PASSWD)
            
            dataEncrypt.writeToFile(filePath, atomically: true)
        } else {
            arrayToWrite?.writeToFile(filePath, atomically: true)
        }
        
        if KQFileHandle.isSkipBackup(filePath) == false {
            if KQFileHandle.addSkipBackupAttributeToItemAtURL(filePath) == true {
                print("Skip Backup Data File!")
            } else {
                print("Skip Backup Failed!")
            }
        } else {
            print("File is Backed!")
        }
    }
    
    class func readData(fileName: String) -> NSData? {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        var resultData: NSData?
        
        if KQFileHandle.filePathExisted(filePath) {
            if KQFileHandle.Encrypted() {
                let encryptedData = NSData(contentsOfFile: filePath)
                
                do {
                    resultData = try RNCryptor.decryptData(encryptedData!, password: FILE_PASSWD)
                    
                    return resultData
                } catch let error as NSError {
                    print("[KQFileHandle]: Read data failed with error: \(error)")
                }
                
            } else {
                return NSData(contentsOfFile: filePath)!
            }
        } else {
            print("[KQFileHandle]: Read data failed with error: File not exists!")
            
            resultData = nil
        }
        
        return resultData
    }
    
    class func readArray(fileName: String) -> NSMutableArray? {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        var resultArray: NSMutableArray?
        
        if KQFileHandle.filePathExisted(filePath) {
            if KQFileHandle.Encrypted() {
                let encryptedData = NSData(contentsOfFile: filePath)
                
                do {
                    let resultData = try RNCryptor.decryptData(encryptedData!, password: FILE_PASSWD)
                    
                    resultArray = NSKeyedUnarchiver.unarchiveObjectWithData(resultData) as? NSMutableArray
                } catch let error as NSError {
                    print("[KQFileHandle]: Read data failed with error: \(error)")
                }
                
            } else {
                return NSMutableArray(contentsOfFile: filePath)!
            }
        } else {
            print("[KQFileHandle]: Read data failed with error: File not exists!")
            
            resultArray = nil
        }
        
        return resultArray
    }
    
    class func readDictionary(fileName: String) -> NSDictionary? {
        let filePath = KQFileHandle.filePathInDocuments(fileName, fileType: FILE_TYPE)
        
        var resultDict: NSDictionary?
        
        if KQFileHandle.filePathExisted(filePath) {
            if KQFileHandle.Encrypted() {
                let encryptedData = NSData(contentsOfFile: filePath)
                
                do {
                    let resultData = try RNCryptor.decryptData(encryptedData!, password: FILE_PASSWD)
                    
                    resultDict = NSKeyedUnarchiver.unarchiveObjectWithData(resultData) as? NSDictionary
                } catch let error as NSError {
                    print("[KQFileHandle]: Read data failed with error: \(error)")
                }
                
            } else {
                return NSDictionary(contentsOfFile: filePath)!
            }
        } else {
            print("[KQFileHandle]: Read data failed with error: File not exists!")
            
            resultDict = nil
        }
        
        return resultDict
    }
    
    class func dataToDictionary(data: NSData) -> NSDictionary? {
        var jsonResult: NSDictionary?
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        } catch let error as NSError {
            print("[KQFileHandle]: Faile to read JSON string with error: \(error)")
            jsonResult = nil
        }
        
        return jsonResult!
    }
    
    class func dictionaryToData(dict: NSDictionary) -> NSData? {        
        return NSKeyedArchiver.archivedDataWithRootObject(dict)
    }
    
    
    class func setEncrypted(temp: Bool) {
        iEncrypted = temp
    }
    
    class func Encrypted() -> Bool {
        return iEncrypted
    }
    
    class func readAllRSS() -> NSMutableArray {
        return KQFileHandle.dictToRSSArray(KQFileHandle.readArray(FILE_RSS)!)!
    }
    
    class func readFavoriteRSS() -> NSMutableArray {
        return KQFileHandle.dictToRSSArray(KQFileHandle.readArray(FILE_FAVORITE)!)!
    }
    
    class func readPage() -> NSMutableArray {
        return KQFileHandle.dictToPageArray(KQFileHandle.readArray(FILE_PAGE)!)!
    }
    
    class func isSkipBackup(filePath: String) -> Bool {
        let URL:NSURL = NSURL.fileURLWithPath(filePath)
        
        let isSkipBackup: Bool
        
        do {
            var isSkip: AnyObject?
            try URL.getResourceValue(&isSkip, forKey: NSURLIsExcludedFromBackupKey)
            
            isSkipBackup = isSkip as! Bool
        } catch let error as NSError {
            isSkipBackup = false
            print("Check Skip Backup Failed With Error: \(error.localizedDescription)")
        }
        
        return isSkipBackup
    }
    
    class func addSkipBackupAttributeToItemAtURL(filePath: String) -> Bool {
        let URL:NSURL = NSURL.fileURLWithPath(filePath)
        
        assert(NSFileManager.defaultManager().fileExistsAtPath(filePath), "File \(filePath) does not exist")
        
        var success: Bool
        
        do {
            try URL.setResourceValue(true, forKey:NSURLIsExcludedFromBackupKey)
            success = true
        } catch let error as NSError {
            
            success = false
            
            print("Error excluding \(URL.lastPathComponent) from backup \(error)");
        }
        
        return success
    }

}


extension KQFileHandle {
    class func arrayToPageDictionary(tempArray: NSMutableArray) -> NSMutableArray? {
        
        let arrayForWrite = NSMutableArray()
        
//        for index in 0..<tempArray.count {
//            var rssPage = KQRSSPage()
//            rssPage = tempArray.objectAtIndex(index) as! KQRSSPage
//            
//            let dictRecord = NSDictionary(objects: [rssPage.Id, rssPage.Title, rssPage.Link], forKeys: [P_ID, P_TITLE, P_LINK])
//            
//            arrayForWrite.addObject(dictRecord)
//        }
        
        return arrayForWrite;
    }
    
    class func dictToPageArray(tempArray: NSMutableArray) -> NSMutableArray? {
        let resultArray = NSMutableArray()
        
//        for index in 0..<tempArray.count {
//            let dictTemp = tempArray.objectAtIndex(index)
//            
//            let rssPage = KQRSSPage()
//            
//            rssPage.Id = dictTemp.objectForKey(P_ID) as! String
//            rssPage.Title = dictTemp.objectForKey(P_TITLE) as! String
//            rssPage.Link = dictTemp.objectForKey(P_LINK) as! String
//            
//            
//            resultArray.addObject(rssPage)
//        }
        
        return resultArray
    }
    
    class func dictToRSSArray(tempArray: NSMutableArray) -> NSMutableArray? {
        let resultArray = NSMutableArray()
        
//        for index in 0..<tempArray.count {
//            let dictTemp = tempArray.objectAtIndex(index)
//            
//            let rssItem = MWFeedItem()
//            
//            rssItem.identifier = dictTemp.objectForKey(R_identifier) as! String
//            rssItem.title = dictTemp.objectForKey(R_title) as! String
//            rssItem.link = dictTemp.objectForKey(R_link) as! String
//            rssItem.date = dictTemp.objectForKey(R_date) as! NSDate
//            rssItem.updated = dictTemp.objectForKey(R_updated) as! NSDate
//            rssItem.summary = dictTemp.objectForKey(R_summary) as! String
//            rssItem.content = dictTemp.objectForKey(R_content) as! String
//            rssItem.author = dictTemp.objectForKey(R_author) as! String
//            rssItem.source = dictTemp.objectForKey(R_source) as! String
////            rssItem.enclosures = dictTemp.objectForKey(R_enclosures) as! [String]
//            
//            resultArray.addObject(rssItem)
//        }
        
        return resultArray
    }
    
    class func arrayToRSSDict(tempArray: NSMutableArray) -> NSMutableArray? {
        let arrayToWrite = NSMutableArray()
        
//        for index in 0..<tempArray.count {
//            var rssItem = MWFeedItem()
//            rssItem = tempArray.objectAtIndex(index) as! MWFeedItem
//            
//            if self.isNilOrEmpty(rssItem.summary) {
//                rssItem.summary = "EISTI"
//            }
//            
//            if self.isNilOrEmpty(rssItem.author) {
//                rssItem.author = "EISTI"
//            }
//
//            if self.isNilOrEmpty(rssItem.identifier) {
//                rssItem.identifier = "EISTI"
//            }
//
//            if self.isNilOrEmpty(rssItem.content) {
//                rssItem.content = "EISTI"
//            }
//            
//            if rssItem.updated == nil {
//                rssItem.updated = NSDate()
//            }
//            
//            if rssItem.date == nil {
//                rssItem.date = NSDate()
//            }
//            
//            
//            if rssItem.source == nil {
//                rssItem.source = "EISTI"
//            }
//
//            
//            let dictRecord = NSDictionary(objects: [rssItem.title, rssItem.link, rssItem.date, rssItem.source, rssItem.summary, rssItem.author, rssItem.identifier, rssItem.content, rssItem.updated], forKeys: [R_title, R_link, R_date, R_source, R_summary, R_author, R_identifier, R_content, R_updated])
//        
//            arrayToWrite.addObject(dictRecord)
//        }
        
        return arrayToWrite
    }
    
    class func isNilOrEmpty(string: NSString?) -> Bool {
        switch string {
        case .Some(let nonNilString):
            return nonNilString.length == 0
        default:
            return true
        }
    }
    
}
