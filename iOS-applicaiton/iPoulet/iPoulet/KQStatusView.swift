//
//  KQStatusView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/24/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class KQStatusView: UIView {
    
    var statusLabel: UILabel!
    var statusImage: UIImageView!
    
//    var indicatorView: KQIndicatorView!
    
    var indicator: NVActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = ALPHA_COLOR
        self.layer.cornerRadius = 5.0
        
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        
        
        self.statusImage = UIImageView(frame: CGRectMake(0, 0, height, height))
        self.statusImage.image = UIImage(named: "icon-normal")
        self.addSubview(self.statusImage)
        
        self.indicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, height, height), type: .BallScaleRippleMultiple, color: UIColor.whiteColor() , padding: 5)
        self.indicator.backgroundColor = UIColor.clearColor()
        self.indicator.layer.shadowColor = UIColor.blackColor().CGColor
        self.indicator.layer.shadowOpacity = 0.6
        self.indicator.layer.shadowRadius = 2.0
        self.indicator.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.indicator.layer.cornerRadius = 5.0
        self.addSubview(self.indicator)
        
        self.statusLabel = UILabel(frame: CGRectMake(height + KQSize.Space(), 0, width - height - 2 * KQSize.Space(), height))
        self.statusLabel.textColor = UIColor.whiteColor()
        self.statusLabel.font = UIFont.italicSystemFontOfSize(14.0)
        self.statusLabel.backgroundColor = UIColor.clearColor()
        self.statusLabel.text = "..."
        self.addSubview(self.statusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        self.statusImage.hidden = true
        self.indicator.hidden = false
        self.indicator.startAnimation()
    }
    
    func stopAnimation() {
        self.statusImage.hidden = false
        self.indicator.hidden = true
        self.indicator.stopAnimation()
    }
    
}
