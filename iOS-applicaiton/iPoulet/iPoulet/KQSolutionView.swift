//
//  KQSolutionView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit

class KQSolutionView: UIViewController {

    var solutionTable: UITableView!
    
    var shouldShowSearchResults = false
    var filteredTableData = [KQSolution]()
    var newsSearchController: KQSearchController!
    
    var listSolution: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Giải pháp"
        
        self.listSolution = NSMutableArray()
        self.listSolution = KQData.ListError()
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - 2 * spaceY)
        
        self.solutionTable = UITableView(frame: CGRectMake(0, 0, KQSize.Width(), viewHeight))
        self.solutionTable.dataSource = self
        self.solutionTable.delegate = self
        self.solutionTable.backgroundColor = UIColor.clearColor()
        self.solutionTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.solutionTable)
        
        self.configureCustomSearchController()
    }
}

extension KQSolutionView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.listSolution.count
        if (self.shouldShowSearchResults) {
            return self.filteredTableData.count
        }
        else {
            return self.listSolution.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var iSolution = KQSolution()
        
        if (self.shouldShowSearchResults) {
            iSolution = self.filteredTableData[indexPath.row]
        } else {
            iSolution = self.listSolution.objectAtIndex(indexPath.row) as! KQSolution
        }
        
        let cell = KQSolutionCell(style: .Default, reuseIdentifier: "solutionCell")
        cell.title.text = iSolution.title
        
        let solutionType: Int = Int(iSolution.type)!
        
        switch solutionType {
        case 1:
            cell.lblColor.backgroundColor = UIColor.flatRedColor()
            break
            
        case 2:
            cell.lblColor.backgroundColor = UIColor.flatOrangeColor()
            break
            
        case 3:
            cell.lblColor.backgroundColor = UIColor.flatBlueColor()
            break
            
        default:
            cell.lblColor.backgroundColor = UIColor.flatPlumColorDark()
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var iSolution = KQSolution()
        
        if (self.shouldShowSearchResults) {
            iSolution = self.filteredTableData[indexPath.row]
        } else {
            iSolution = self.listSolution.objectAtIndex(indexPath.row) as! KQSolution
        }
        
        KQData.setCurrentItem(iSolution)
        
        if KQNetwork.reachNetwork().isReachable() {
            self.showRSSView(iSolution)
        } else {
            KQData.showToast("Vui lòng bật WiFi hoặc 3G!")
        }
    }
    
    func showRSSView(rssItem: KQSolution) {
        let rssView = KQSolutionAnalyseView()
        rssView.webLink = NSURL(string: rssItem.link)
        
        self.navigationController?.pushViewController(rssView, animated: true)
    }
}

extension KQSolutionView: KQSearchControllerDelegate {
    //MARK: NEWS Search Controller
    func configureCustomSearchController() {
        var searchHeight: CGFloat = 50
        if KQData.iPad() {
            searchHeight = 60
        }
        
        self.newsSearchController = KQSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, self.solutionTable.frame.size.width, searchHeight), searchBarFont: UIFont.boldSystemFontOfSize(16), searchBarTextColor: UIColor.lightGrayColor(), searchBarTintColor: BG_COLOR)
        
        self.newsSearchController.customSearchBar.placeholder = "Tìm kiếm ..."
        self.solutionTable.tableHeaderView = newsSearchController.customSearchBar
        
        self.newsSearchController.customDelegate = self
    }
    
    
    // MARK: UISearchBarDelegate functions
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.solutionTable.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.solutionTable.reloadData()
    }
    
    // MARK: UISearchResultsUpdating delegate function
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        self.filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@", searchString)
        let array = (self.listSolution as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredTableData = array as! [KQSolution]
        
//        if self.filteredTableData.count <= 0 {
//            KQData.showToast("Không tìm thấy!")
//        }
        // Reload the tableview.
        self.solutionTable.reloadData()
    }
    
    
    // MARK: KQSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        self.solutionTable.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.solutionTable.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        self.solutionTable.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        self.filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
        let array = (self.listSolution as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredTableData = array as! [KQSolution]
        
//        if self.filteredTableData.count <= 0 {
//            KQData.showToast("Không tìm thấy!")
//        }
        // Reload the tableview.
        self.solutionTable.reloadData()
    }
}




