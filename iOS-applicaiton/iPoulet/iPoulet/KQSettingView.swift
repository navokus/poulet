//
//  KQSettingView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQSettingView: UIViewController {

    
    var logoView : MDButton!
    var lblVersion: UILabel!
    var tblSetting: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Cài đặt"
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    func drawView() {
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - KQSize.HiddenHeight() - 4 * spaceY)/8
        
        self.logoView = MDButton(frame: CGRectMake((KQSize.Width() - viewHeight * 2)/2, spaceY + viewHeight * 1.5, viewHeight * 2, viewHeight * 2), type: MDButtonType.Flat, rippleColor: UIColor.whiteColor())
        self.logoView.backgroundColor = OB_COLOR
        self.logoView.layer.shadowColor = UIColor.blackColor().CGColor
        self.logoView.layer.shadowOpacity = 0.6
        self.logoView.layer.shadowRadius = 2.0
        self.logoView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.logoView.layer.cornerRadius = 5.0
        self.logoView.setImage(UIImage(named: "icon-logo"), forState: .Normal)
        self.view.addSubview(self.logoView)
        
        
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as! String
        
        self.lblVersion = UILabel(frame: CGRectMake(0, self.logoView.frame.origin.y + self.logoView.frame.size.height, KQSize.Width(), 3 * spaceY))
        self.lblVersion.text = "Phiên bản \(version)"
        self.lblVersion.font = UIFont(name: "UTM-Avo", size: 15)//UIFont.italicSystemFontOfSize(13)
        self.lblVersion.textAlignment = .Center
        self.lblVersion.textColor = UIColor.whiteColor()
        self.view.addSubview(self.lblVersion)
        
        self.tblSetting = UITableView(frame: CGRectMake(0, viewHeight * 3.5 + 4 * spaceY, KQSize.Width(), viewHeight * 6.5))
        self.tblSetting.dataSource = self
        self.tblSetting.delegate = self
        self.tblSetting.backgroundColor = UIColor.clearColor()
        self.tblSetting.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tblSetting)
    }
}

extension KQSettingView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = KQSettingCell(style: .Default, reuseIdentifier: "settingCell")
        
        
        switch indexPath.row {
        case 0:
            cell.title.text = "Đặt lịch quét"
            cell.icon.image = UIImage(named: "icon-calendar")
            cell.info.hidden = true
            cell.switchEnable.hidden = true
            break
        
        case 1:
            cell.title.text = "Cài đặt cảnh báo"
            cell.icon.image = UIImage(named: "icon-noti")
            cell.info.hidden = true
            cell.switchEnable.hidden = true
            break
            
            
        case 2:
            cell.title.text = "Quản lý website"
            cell.icon.image = UIImage(named: "icon-website")
            cell.info.hidden = true
            cell.switchEnable.hidden = true
            break
            
        case 3:
            cell.title.text = "Các gói dịch vụ"
            cell.icon.image = UIImage(named: "icon-service")
            cell.info.hidden = true
            cell.switchEnable.hidden = true
            break
            
        case 4:
            cell.title.text = "Nhóm phát triển"
            cell.icon.image = UIImage(named: "icon-team")
            cell.info.hidden = true
            cell.switchEnable.hidden = true
            break
            
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if KQData.iPad() {
            return 65
        }
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Index path: \(indexPath.row)")
    }

}
