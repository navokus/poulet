//
//  KQSettingCell.swift
//  TheNews
//
//  Created by QuocKhai on 5/15/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

class KQSettingCell: MDTableViewCell {

//    var view: UIView!
    var title: UILabel!
    var info: UILabel!
    var icon: UIImageView!
    var switchEnable: UISwitch!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var cellHeight: CGFloat = 50
        let width = KQSize.Width()//self.frame.size.width
        let spaceX : CGFloat = 10
        
        if KQData.iPad() {
            cellHeight = 65
//            spaceX = 20
        }
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
        self.icon = UIImageView(frame: CGRectMake(spaceX, spaceX, cellHeight - 2 * spaceX, cellHeight - 2 * spaceX))
        self.icon.image = UIImage(named: "icon-rss")
        self.icon.layer.shadowColor = UIColor.blackColor().CGColor
        self.icon.layer.shadowOpacity = 0.6
        self.icon.layer.shadowRadius = 2.0
        self.icon.layer.shadowOffset = CGSizeMake(2.0, 2.0)
//        self.icon.backgroundColor = UIColor.orangeColor()
        self.addSubview(self.icon)
        
        let textHeight: CGFloat = cellHeight/2
        let textWidth: CGFloat = (width - cellHeight - spaceX)/3
        
        self.title = UILabel(frame: CGRect(x: cellHeight, y: 0, width: textWidth * 2, height: textHeight*2))
        self.title.text = "Kiểu chữ"
        self.title.textColor = TEXT_COLOR
        self.title.font = UIFont(name: "UTM-Avo", size: 15)//UIFont.boldSystemFontOfSize(textHeight*0.6)
        self.title.numberOfLines = 0
        
        self.addSubview(self.title)
        
        let line = UILabel(frame: CGRectMake(0, cellHeight - 1, width, 1))
        line.backgroundColor = UIColor.whiteColor()
        self.addSubview(line)
        
        self.info = UILabel(frame: CGRect(x: cellHeight + textWidth*2, y: 0, width: textWidth - spaceX/2, height: textHeight*2))
        self.info.text = "21:30"
        self.info.textColor = TEXT_COLOR
        self.info.font = UIFont(name: "UTM-Avo", size: 15)//UIFont.italicSystemFontOfSize(textHeight*0.6)
        self.info.numberOfLines = 0
        self.info.textAlignment = NSTextAlignment.Right
//        self.info.backgroundColor = UIColor.redColor()
//        self.info.layer.cornerRadius = 5.0
        self.addSubview(self.info)
        
        self.switchEnable = UISwitch(frame: CGRect(x: width - spaceX - 60, y: spaceX, width: 0, height: 0))
        self.switchEnable.onTintColor = UIColor.whiteColor()
//        self.switchEnable.addTarget(self, action: #selector(KQAlarmCell.changeAlarmState(_:)), forControlEvents: .ValueChanged)
//        self.switchEnable.backgroundColor = UIColor.orangeColor()
        self.switchEnable.hidden = true
        self.addSubview(self.switchEnable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
