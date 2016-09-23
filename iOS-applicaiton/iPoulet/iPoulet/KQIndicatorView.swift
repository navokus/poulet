//
//  KQIndicatorView.swift
//  RestfulTwo
//
//  Created by QuocKhai on 4/15/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class KQIndicatorView: UIView {
    
    var indicator: NVActivityIndicatorView!
    var parentViewController: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.parentViewController = UIViewController()
        
        var spaceX: CGFloat = 20
        var spaceY: CGFloat = 20
        
        
        if KQData.iPad() {
            spaceX = 30
            spaceY = 45
        }
        
        
        let viewHeight: CGFloat = (KQSize.Height() - 4 * spaceY)/6
        
        self.backgroundColor = UIColor.clearColor()
        
        self.indicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, viewHeight * 1.2, viewHeight * 1.2), type: .BallClipRotateMultiple, color: UIColor.whiteColor() , padding: spaceX)
        self.indicator.center = self.parentViewController.view.center
    
        self.indicator.backgroundColor = OB_COLOR//UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.indicator.layer.shadowColor = UIColor.blackColor().CGColor
        self.indicator.layer.shadowOpacity = 0.6
        self.indicator.layer.shadowRadius = 2.0
        self.indicator.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.indicator.layer.cornerRadius = 5.0
        self.addSubview(self.indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        self.parentViewController.view.addSubview(self)
        self.indicator.startAnimation()
    }
    
    func stopAnimation() {
        self.removeFromSuperview()
        self.indicator.stopAnimation()
    }
}

/*
 01. BallPulse
 02. BallGridPulse
 03. BallClipRotate
 04. SquareSpin
 05. BallClipRotatePulse
 06. BallClipRotateMultiple
 07. BallPulseRise
 08. BallRotate
 09. CubeTransition
 10. BallZigZag
 11. BallZigZagDeflect
 12. BallTrianglePath
 13. BallScale
 14. LineScale
 15. LineScaleParty
 16. BallScaleMultiple
 17. BallPulseSync
 18. BallBeat
 19. LineScalePulseOut
 20. LineScalePulseOutRapid
 21. BallScaleRipple
 22. BallScaleRippleMultiple
 23. BallSpinFadeLoader
 24. LineSpinFadeLoader
 25. TriangleSkewSpin
 26. Pacman
 27. BallGridBeat
 28. SemiCircleSpin
 29. BallRotateChase
 */
