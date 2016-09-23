//
//  KQSize.swift
//  iPosture
//
//  Created by Quoc Khai on 9/14/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

var screenWidth : CGFloat!
var screenHeight : CGFloat!

var iHeight: CGFloat!
var iHeaderHeight: CGFloat!
var iFooterHeighr: CGFloat!

class KQSize: NSObject {
    
    class func Space() -> CGFloat {
        if KQData.iPad() {
            return 40.0
        }
        return 10.0
    }
    
    class func FontSize() -> CGFloat {
        if KQData.iPad() {
            return 30.0
        }
        return 18.0
    }
        
    // -- Set screen width
    class func Width() -> CGFloat{
        return screenWidth
    }
    
    class func setWidth(temp:CGFloat){
        screenWidth = temp
    }
    
    // -- Set screen height
    class func Height() -> CGFloat{
        return screenHeight
    }
    
    class func setHeight(temp:CGFloat){
        screenHeight = temp
    }
    
    class func HiddenHeight() -> CGFloat {
        return iHeight
    }
    
    class func setHiddenHeight(temp: CGFloat) {
        iHeight = temp
    }
    
    class func HeaderHeight() -> CGFloat {
        return iHeaderHeight
    }
    
    class func setHeaderHeight(temp: CGFloat) {
        iHeaderHeight = temp
    }
    
    
    class func FooterHeight() -> CGFloat {
        return iFooterHeighr
    }
    
    class func setFooterHeight(temp: CGFloat) {
        iFooterHeighr = temp
    }


}
