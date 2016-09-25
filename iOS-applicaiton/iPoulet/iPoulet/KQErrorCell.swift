//
//  KQErrorCell.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQErrorCell: MDTableViewCell {
    var view: UIView!
    
    var lblColor: UILabel!
    var title: UILabel!
    
    var iconNumber: MDButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellHeight: CGFloat = (KQSize.Height() - KQSize.HiddenHeight() - 6 * KQSize.Space())/7 - 5
        var spaceX : CGFloat = 10
        
        if KQData.iPad() {
            spaceX = 40
        }
        
        self.backgroundColor = UIColor.clearColor()
        
        let width = KQSize.Width()
        
        self.view = UIView(frame: CGRectMake(spaceX, 5, width - 2 * spaceX, cellHeight))
        self.view.layer.shadowColor = UIColor.blackColor().CGColor
        self.view.layer.shadowOpacity = 0.6
        self.view.layer.shadowRadius = 2.0
        self.view.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        //        self.view.layer.cornerRadius = 5.0
        self.view.backgroundColor = OB_COLOR
        self.view.userInteractionEnabled = false
        self.addSubview(self.view)
        
        
        self.lblColor = UILabel(frame: CGRectMake(0, 0, 5, cellHeight))
        self.lblColor.backgroundColor = KQData.randomColor()
        self.view.addSubview(self.lblColor)
        
        self.title = UILabel(frame: CGRect(x: 5 + spaceX, y: 0, width: width - 3 - spaceX - cellHeight, height: cellHeight))
        self.title.text = "Kiểu chữ"
        self.title.textColor = TEXT_COLOR
        self.title.font = UIFont.boldSystemFontOfSize(cellHeight/3)
        self.title.numberOfLines = 0
        //        self.title.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(self.title)
        
        self.iconNumber = MDButton(frame: CGRectMake(width - cellHeight - spaceX * 1.5, spaceX/2, cellHeight - spaceX, cellHeight - spaceX), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.iconNumber.setTitle("", forState: .Normal)
        self.iconNumber.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.iconNumber.backgroundColor = OB_COLOR
        self.view.addSubview(self.iconNumber)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
