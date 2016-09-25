//
//  KQSolutionPopup.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/24/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import PopupController

class KQSolutionPopup: UIViewController, PopupContentViewController {
    
    var imgIcon: UIImageView!
    var lblName: UILabel!
    var lblDescription: UITextView!
    var btnDetails: MDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var spaceX: CGFloat = 20
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        let popupSize: CGFloat = KQSize.Width() - 2 * spaceX
        
        self.view.frame.size = CGSizeMake(popupSize, popupSize)
        
        self.view.backgroundColor = OB_COLOR//KQData.randomColor()
        self.view.layer.cornerRadius = 10.0
        self.view.layer.masksToBounds = true
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    class func instance() -> KQCampusPopup {
    //        return KQCampusPopup()
    //    }
    
    func drawView() {
        var spaceX: CGFloat = 10
        var spaceY: CGFloat = 10
        var fontSize: CGFloat = 16
        
        if KQData.iPad() {
            spaceX = 20
            spaceY = 20
            fontSize = 30
        }
        
        let viewHeight: CGFloat = self.view.frame.height/5
        let width: CGFloat = self.view.frame.width
        
        self.imgIcon = UIImageView(frame: CGRectMake(0, 0, viewHeight, viewHeight))
        self.imgIcon.image = UIImage(named: "icon-hack")
        self.view.addSubview(self.imgIcon)
        
        self.lblName = UILabel(frame: CGRectMake(viewHeight + spaceX/2, 0, width - viewHeight - spaceX, viewHeight))
        self.lblName.textAlignment = .Center
        self.lblName.textColor = UIColor.whiteColor()
        self.lblName.font = UIFont.boldSystemFontOfSize(fontSize)
        self.lblName.adjustsFontSizeToFitWidth = true
        self.lblName.text = "SQL Injection"
        self.lblName.numberOfLines = 0
        self.view.addSubview(self.lblName)
        
        
//        let lineOne = UILabel(frame: CGRectMake(0, viewHeight - 1, width, 1))
//        lineOne.backgroundColor = UIColor.whiteColor()
        
//        let lineTwo = UILabel(frame: CGRectMake(0, viewHeight - 1, width, 1))
//        lineTwo.backgroundColor = UIColor.whiteColor()
        
        
        self.lblDescription = UITextView(frame: CGRectMake(0, viewHeight, width, viewHeight * 3))
        self.lblDescription.backgroundColor = ALPHA_COLOR
        self.lblDescription.textColor = UIColor.whiteColor()
        self.lblDescription.font = UIFont.systemFontOfSize(fontSize)
        self.lblDescription.editable = false
        self.lblDescription.text = "SQL Injection là một kỹ thuật cho phép những kẻ tấn công lợi dụng lỗ hổng của việc kiểm tra dữ liệu đầu vào trong các ứng dụng web và các thông báo lỗi của hệ quản trị cơ sở dữ liệu trả về để inject (tiêm vào) và thi hành các câu lệnh SQL bất hợp pháp. SQL injection có thể cho phép những kẻ tấn công thực hiện các thao tác, delete, insert, update,… trên cơ sở dữ liệu của ứng dụng, thậm chí là server mà ứng dụng đó đang chạy, lỗi này thường xảy ra trên các ứng dụng web có dữ liệu được quản lý bằng các hệ quản trị cơ sở dữ liệu như SQL Server, MySQL, Oracle, DB2, Sysbase..."
        self.view.addSubview(self.lblDescription)
        
        self.btnDetails = MDButton(frame: CGRectMake(0, viewHeight * 4, width, viewHeight), type: .Raised, rippleColor: UIColor.whiteColor())
        self.btnDetails.setTitle("Chi tiết", forState: .Normal)
//        self.btnDetails.addTarget(self, action: #selector(KQLinkPopup.loginHandle), forControlEvents: .TouchDown)
        self.btnDetails.backgroundColor = OB_COLOR
        self.view.addSubview(self.btnDetails)
        
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        var spaceX: CGFloat = 20
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        let popupSize: CGFloat = KQSize.Width() - 2 * spaceX
        
        return CGSizeMake(popupSize, popupSize)
    }
    
}
