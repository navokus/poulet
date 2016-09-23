//
//  KQNewsCell.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQNewsCell: MDTableViewCell {
    var view: UIView!
    var title: UILabel!
    var time: UILabel!
    //    var source: UILabel!
//    var icon: UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellHeight: CGFloat = 75
        var spaceX : CGFloat = 10
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        self.backgroundColor = UIColor.clearColor()
        
        let width = KQSize.Width()//self.frame.size.width//KQData.Width()
        
        self.view = UIView(frame: CGRectMake(spaceX, 5, width - 2 * spaceX, cellHeight))
        self.view.layer.shadowColor = UIColor.blackColor().CGColor
        self.view.layer.shadowOpacity = 0.6
        self.view.layer.shadowRadius = 2.0
        self.view.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.view.layer.cornerRadius = 5.0
        self.view.backgroundColor = OB_COLOR
        self.view.userInteractionEnabled = false
        self.addSubview(self.view)
        
//        self.icon = UIImageView(frame: CGRectMake(spaceX, spaceX, cellHeight - 2 * spaceX, cellHeight - 2 * spaceX))
//        self.icon.image = UIImage(named: "icon-rss")
//        self.icon.layer.shadowColor = UIColor.blackColor().CGColor
//        self.icon.layer.shadowOpacity = 0.6
//        self.icon.layer.shadowRadius = 2.0
//        self.icon.layer.shadowOffset = CGSizeMake(2.0, 2.0)
//        //        self.icon.backgroundColor = UIColor.orangeColor()
//        self.view.addSubview(self.icon)
        
        let textHeight: CGFloat = cellHeight/3
        let textWidth: CGFloat = (self.view.frame.size.width)/2// - cellHeight)
        
        self.title = UILabel(frame: CGRect(x: spaceX, y: 0, width: textWidth*2 - 2 * spaceX, height: textHeight*2))
        self.title.text = "Akamai kicked journalist Brian Krebs' site off its servers after he was hit by a 'record' cyberattack"
        self.title.textColor = TEXT_COLOR
        self.title.font = UIFont.boldSystemFontOfSize(textHeight*0.6)
        self.title.numberOfLines = 0
        //        self.title.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(self.title)
        
        self.time = UILabel(frame: CGRectMake(spaceX, textHeight*2, textWidth * 2 - 2 * spaceX, textHeight))
        self.time.textColor = TEXT_COLOR
        self.time.font = UIFont.italicSystemFontOfSize(textHeight*0.4)
        self.time.text = "A minute ago"
        self.view.addSubview(self.time)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
