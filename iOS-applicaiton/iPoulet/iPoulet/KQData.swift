//
//  KQData.swift
//  FranceDict
//
//  Created by Nguyen Khai on 10/20/14.
//  Copyright (c) 2014 Quoc-Khai. All rights reserved.
//


import UIKit
//import SwiftyJSON

var isIPad: Bool!
var isNoAds: Bool!

var iRootView: AnyObject!

var iColor: UInt32!


class KQData: NSObject {

    // -- Set is iPad
    class func iPad() -> Bool{
        return isIPad
    }
    
    class func setIsIPad(temp:Bool){
        isIPad = temp
    }
    
    // -- Set hidden ads
    class func noAds() -> Bool {
        return isNoAds
    }
    
    class func setNoAds(temp: Bool) {
        isNoAds = temp
    }
    
        
    // -- Root view controller
    class func rootView() -> AnyObject {
        return iRootView
    }
    
    class func setRootView(temp: AnyObject) {
        iRootView = temp
    }


    class func captureView(view:UIView) -> UIImage {
        let viewRect: CGRect = view.bounds
        
        UIGraphicsBeginImageContext(viewRect.size)
        let contextView: CGContextRef = UIGraphicsGetCurrentContext()!
        view.layer.renderInContext(contextView)
        
        let resultImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    
    class func dateFromString(strDate: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        
        return dateFormatter.dateFromString(strDate)!
    }
    
    class func stringFromDate(dateTemp: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        
        return dateFormatter.stringFromDate(dateTemp)
    }

    
    class func showToast(message: String) {
        let iToast: MDToast = MDToast(text: message, duration: Double(kMDToastDurationLong))
        iToast.show()
    }
    
    class func showToast(message: String, time: Double) {
        let iToast: MDToast = MDToast(text: message, duration: time)
        iToast.show()
    }
    

    class func SystemFont() {
        let sysFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
        print("System Font: [Family: \(sysFont.familyName)] - [Name: \(sysFont.fontName)]")
        print("-----------------------------------------------------------------")
    }
    
   class func printFonts() {
        let sysFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
        print("System Font: [Family: \(sysFont.familyName)] - [Name: \(sysFont.fontName)]")
        print("------------------------------------------------------------")
    
    
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName)
            print("Font Names = [\(names)]")
        }
    }

    
    class func UIColorHex(hex: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   
    
    class func GUIDString() -> String {
        let newUniqueID = CFUUIDCreate(kCFAllocatorDefault)
        let newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID)
        let guid = newUniqueIDString as String
        
        return guid.lowercaseString
    }
    
    // -- Random background color
    class func ColorIndex() -> UInt32 {
        return iColor
    }
    
    class func setColorIndex(temp: UInt32) {
        iColor = temp
    }

    
//    class func randomColor() -> NSMutableArray {
//        let arrColor = NSMutableArray()
//        
//        let colorIndex: UInt32 = (KQData.ColorIndex()+1) % 8
//        
//        var backgroundColor: UIColor = UIColor.flatLimeColor()
//        var objectColor: UIColor = UIColor.flatLimeColorDark()
//        
//        switch colorIndex {
//        case 0:
//            backgroundColor = UIColor.flatNavyBlueColor()
//            objectColor = UIColor.flatNavyBlueColorDark()
//            break
//            
//        case 1:
//            backgroundColor = UIColor.flatForestGreenColor()
//            objectColor = UIColor.flatForestGreenColorDark()
//            break
//            
//        case 2:
//            backgroundColor = UIColor.flatPurpleColor()
//            objectColor = UIColor.flatPurpleColorDark()
//            break
//            
//        case 3:
//            backgroundColor = UIColor.flatPlumColor()
//            objectColor = UIColor.flatPlumColorDark()
//            break
//            
//        case 4:
//            backgroundColor = UIColor.flatSkyBlueColor()
//            objectColor = UIColor.flatSkyBlueColorDark()
//            break
//            
//        case 5:
//            backgroundColor = UIColor.flatMintColor()
//            objectColor = UIColor.flatMintColorDark()
//            break
//            
//
//        case 6:
//            backgroundColor = UIColor.flatBlueColor()
//            objectColor = UIColor.flatBlueColorDark()
//            break
//            
//        case 7:
//            backgroundColor = UIColor.flatCoffeeColor()
//            objectColor = UIColor.flatCoffeeColorDark()
//            break
//            
//        default:
//            break
//            
//        }
//        
//        KQData.setColorIndex(colorIndex)
//        
//        arrColor.addObject(backgroundColor)
//        arrColor.addObject(objectColor)
//        
//        return arrColor
//    }
    
    class func randomColor() -> UIColor {
        let colorIndex: UInt32 = (KQData.ColorIndex()+1) % 6
        var resultColor: UIColor = UIColor.flatSandColor()
        
        switch colorIndex {
        
        case 0:
            resultColor = UIColor.flatWatermelonColor()
            break
            
        case 1:
            resultColor = UIColor.flatSkyBlueColor()
            break
            
        case 2:
            resultColor = UIColor.flatRedColor()
            break
            
        case 3:
            resultColor = UIColor.flatGreenColor()
            break
            
        case 4:
            resultColor = UIColor.flatMagentaColor()
            break

        case 5:
            resultColor = UIColor.flatMintColor()
            break
            
        default:
            break
            
        }
        
        KQData.setColorIndex(colorIndex)
        
        return resultColor
    }
    
    class func Color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
        
}


