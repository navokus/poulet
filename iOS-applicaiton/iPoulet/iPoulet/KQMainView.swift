//
//  KQMainView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import Charts

class KQMainView: UIViewController {

    var errorTable: UITableView!
    var pieChart: PieChartView!
    var scanButton: MDButton!
    var calendarButton: MDButton!
    var contactButton: MDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
