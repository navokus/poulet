//
//  KQNewsView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQNewsView: UIViewController {

    var newsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Tin tức"
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - 2 * spaceY)
        
        self.newsTable = UITableView(frame: CGRectMake(0, 0, KQSize.Width(), viewHeight))
        self.newsTable.dataSource = self
        self.newsTable.delegate = self
        self.newsTable.backgroundColor = UIColor.clearColor()
        self.newsTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.newsTable)
    }
}

extension KQNewsView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = KQNewsCell(style: .Default, reuseIdentifier: "newsCell")
        
        return cell 
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
