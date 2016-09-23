//
//  KQLogView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQLogView: UIViewController {
    
    var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Log"
        
        let backItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KQLogView.backView))
        backItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = backItem
        
        
        self.drawView()
    }
    
    func backView() {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - KQSize.HiddenHeight() - 2 * spaceY)
        
        self.logTextView = UITextView(frame: CGRectMake(spaceY, spaceY + KQSize.HeaderHeight(), KQSize.Width() - 2 * spaceY, viewHeight))
        self.logTextView.backgroundColor = OB_COLOR
        self.logTextView.textColor = UIColor.whiteColor()
        self.logTextView.textAlignment = .Left
        self.logTextView.layer.cornerRadius = 5.0
        self.logTextView.layer.masksToBounds = true
        self.logTextView.font = UIFont.italicSystemFontOfSize(16.0)
        self.logTextView.text = ""
        self.logTextView.editable = false
        self.view.addSubview(self.logTextView)
    }
}