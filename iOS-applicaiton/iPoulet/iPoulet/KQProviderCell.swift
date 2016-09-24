//
//  KQProviderCell.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/24/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQProviderCell: MDTableViewCell {
    var view: UIView!
    var title: UILabel!
    var describe: UILabel!
    //    var source: UILabel!
    var icon: UIImageView!
    
    var call: MDButton!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellHeight: CGFloat = 85
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
        
        self.icon = UIImageView(frame: CGRectMake(spaceX, spaceX, cellHeight - 2 * spaceX, cellHeight - 2 * spaceX))
        self.icon.image = UIImage(named: "icon-rss")
        self.icon.layer.shadowColor = UIColor.blackColor().CGColor
        self.icon.layer.shadowOpacity = 0.6
        self.icon.layer.shadowRadius = 2.0
        self.icon.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        //        self.icon.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(self.icon)
        
        let textHeight: CGFloat = (cellHeight - 5)/3
        let textWidth: CGFloat = (self.view.frame.size.width)/2// - cellHeight)
        
        self.title = UILabel(frame: CGRect(x: cellHeight, y: 0, width: textWidth*2 - spaceX - cellHeight, height: textHeight))
        self.title.text = "Việt Website"
        self.title.textColor = TEXT_COLOR
        self.title.font = UIFont.boldSystemFontOfSize(textHeight*0.6)
        self.title.numberOfLines = 0
        //        self.title.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(self.title)
        
        self.describe = UILabel(frame: CGRectMake(cellHeight, textHeight, textWidth * 2 - spaceX - cellHeight, textHeight))
        self.describe.textColor = TEXT_COLOR
        self.describe.font = UIFont.italicSystemFontOfSize(textHeight*0.4)
        self.describe.text = "A minute ago"
        self.describe.numberOfLines = 0
        self.view.addSubview(self.describe)
        
        let buttonWidth: CGFloat = (textWidth * 2 - spaceX - cellHeight)/2
        self.call = MDButton(frame: CGRectMake(self.view.frame.size.width - buttonWidth - spaceX, textHeight * 2, buttonWidth, textHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.call.setTitle("Liên hệ", forState: .Normal)
        self.call.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.call.backgroundColor = UIColor.flatGreenColor()
        self.call.addTarget(self, action: #selector(KQProviderCell.contactProvider), forControlEvents: .TouchDown)
        self.view.addSubview(self.call)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contactProvider() {
        print("contactProvider")
    }

}
