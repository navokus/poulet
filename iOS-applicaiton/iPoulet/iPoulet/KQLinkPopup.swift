//
//  KQLinkPopup.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import PopupController

class KQLinkPopup: UIViewController, PopupContentViewController, UITextFieldDelegate {

    var txtTime: UITextField!
    var btnLogin: MDButton!
    
    var setTimeHandler: (() -> Void)?
    
    var imgIcon: UIImageView!
    var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var spaceX: CGFloat = 20
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        let popupSize: CGFloat = KQSize.Width() - 2 * spaceX
        
        self.view.frame.size = CGSizeMake(popupSize, popupSize * 0.6)
        
        self.view.backgroundColor = OB_COLOR
        self.view.layer.cornerRadius = 10.0
        self.view.layer.masksToBounds = true
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        var spaceX: CGFloat = 10
        var spaceY: CGFloat = 10
        var fontSize: CGFloat = 20
        
        if KQData.iPad() {
            spaceX = 20
            spaceY = 20
            fontSize = 30
        }
        
        let viewHeight: CGFloat = self.view.frame.height/5
        let width: CGFloat = self.view.frame.width
        
        self.imgIcon = UIImageView(frame: CGRectMake(spaceX, spaceY, viewHeight * 2 - 2 * spaceX, viewHeight * 2 - 2 * spaceY))
        self.imgIcon.image = UIImage(named: "icon-web")
        self.view.addSubview(self.imgIcon)
        
        self.lblName = UILabel(frame: CGRectMake(2 * viewHeight, 0, width - 2 * viewHeight, viewHeight * 2))
        self.lblName.textAlignment = .Center
        self.lblName.textColor = UIColor.whiteColor()
        self.lblName.font = UIFont.boldSystemFontOfSize(viewHeight)
        self.lblName.adjustsFontSizeToFitWidth = true
        self.lblName.text = "Website"
        //        self.lblName.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(self.lblName)
        
        let lineOne = UILabel(frame: CGRectMake(0, viewHeight * 1.5 - 1, width, 1))
        lineOne.backgroundColor = UIColor.whiteColor()
        
        //        let lineTwo = UILabel(frame: CGRectMake(0, viewHeight - 1, width, 1))
        //        lineTwo.backgroundColor = UIColor.whiteColor()
        
        
        self.txtTime = UITextField(frame: CGRectMake(0, viewHeight * 2, width, viewHeight * 1.5))
        self.txtTime.backgroundColor = ALPHA_COLOR
        self.txtTime.textColor = TEXT_COLOR
        self.txtTime.font = UIFont.systemFontOfSize(fontSize)
        self.txtTime.placeholder = "  Link"
        self.txtTime.addSubview(lineOne)
        self.txtTime.delegate = self
        //        self.txtPassword.text = "trinhthith"
        self.txtTime.keyboardType = .URL
        self.txtTime.autocapitalizationType = .None
        self.view.addSubview(self.txtTime)
        
        self.btnLogin = MDButton(frame: CGRectMake(0, viewHeight * 3.5, width, viewHeight * 1.5), type: .Raised, rippleColor: UIColor.whiteColor())
        self.btnLogin.setTitle("Quét", forState: .Normal)
        self.btnLogin.addTarget(self, action: #selector(KQLinkPopup.loginHandle), forControlEvents: .TouchDown)
        self.btnLogin.backgroundColor = OB_COLOR
        self.view.addSubview(self.btnLogin)
        
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        var spaceX: CGFloat = 20
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        let popupSize: CGFloat = KQSize.Width() - 2 * spaceX
        
        return CGSizeMake(popupSize, popupSize * 0.6)
    }
    
    func loginHandle() {
        self.setTimeHandler?()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    

}
