//
//  KQNavigationController.swift
//  EISTI
//
//  Created by QuocKhai on 6/7/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

class KQNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UINavigationBar.appearance().barTintColor = BD_COLOR//OB_COLOR
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().layer.shadowColor = UIColor.blackColor().CGColor
        UINavigationBar.appearance().layer.shadowOffset = CGSizeMake(2.0, 2.0)
        UINavigationBar.appearance().layer.shadowRadius = 2.0
        UINavigationBar.appearance().layer.shadowOpacity = 0.6
        
        
        let fontNav: UIFont = UIFont.boldSystemFontOfSize(20)
        
        let navigationTitleAttribute = NSDictionary(objects: [UIColor.whiteColor(), fontNav], forKeys: [NSForegroundColorAttributeName, NSFontAttributeName])
        
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
