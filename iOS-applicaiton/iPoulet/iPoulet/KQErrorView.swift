//
//  KQErrorView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQErrorView: UIView {
    
    var iconImage: UIImageView!
    var errorLabel: UILabel!
    var numberLabel: MDButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.flatRedColor()
        
        let space: CGFloat = KQSize.Space()
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 5.0
        
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        
        self.iconImage = UIImageView(frame: CGRectMake(0, 0, height, height))
        self.iconImage.image = UIImage(named: "bar-learn")
        self.addSubview(self.iconImage)
        
        self.errorLabel = UILabel(frame: CGRectMake(height, 0, width - 2 * height, height))
        self.errorLabel.textColor = UIColor.whiteColor()
        self.errorLabel.font = UIFont.boldSystemFontOfSize(KQSize.FontSize())
        self.errorLabel.text = "Lỗi nguy hiểm"
        self.addSubview(self.errorLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
