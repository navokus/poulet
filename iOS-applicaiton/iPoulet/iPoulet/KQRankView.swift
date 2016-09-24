//
//  KQRankView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/24/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQRankView: UIViewController {

    var providerTable: UITableView!

    
    var listProvider: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Top 10 - Nhà cung cấp Website"
        
        self.listProvider = NSMutableArray()
        self.listProvider = KQData.ListProvider()
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - 2 * spaceY)
        
        self.providerTable = UITableView(frame: CGRectMake(0, 0, KQSize.Width(), viewHeight))
        self.providerTable.dataSource = self
        self.providerTable.delegate = self
        self.providerTable.backgroundColor = UIColor.clearColor()
        self.providerTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.providerTable)
        
    }
}

extension KQRankView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iSolution: KQProvider = self.listProvider.objectAtIndex(indexPath.row) as! KQProvider
        
        
        let cell = KQProviderCell(style: .Default, reuseIdentifier: "providerCell")
        cell.title.text = iSolution.title
        cell.describe.text = iSolution.describe
        
        let imageName: String = "icon-site-\(indexPath.row)"
        cell.icon.image = UIImage(named: imageName)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let iSolution: KQProvider = self.listProvider.objectAtIndex(indexPath.row) as! KQProvider
        
        
    }
    
    func showRSSView(rssItem: KQSolution) {
        let rssView = KQSolutionAnalyseView()
        rssView.webLink = NSURL(string: rssItem.link)
        
        self.navigationController?.pushViewController(rssView, animated: true)
    }
}
