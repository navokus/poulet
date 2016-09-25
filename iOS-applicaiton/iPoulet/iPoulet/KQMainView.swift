//
//  KQMainView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import Charts
import PopupController
import SwiftyJSON

class KQMainView: UIViewController, MFMailComposeViewControllerDelegate {

//    var errorTable: UITableView!
    
//    var errorOneView: KQErrorView!
//    var errorTwoView: KQErrorView!
//    var errorThreeView: KQErrorView!
    
    var pieChart: PieChartView!
    
    var statusView: KQStatusView!
    
    var scanButton: MDButton!
    var calendarButton: MDButton!
    var contactButton: MDButton!
    
    var postureTwoStyle: [String]! = ["Rất nguy hiểm", "Nguy hiểm"]
    var postureThreeStyle: [String]! = ["Rất nguy hiểm", "Nguy hiểm", "Cơ bản"]
    var posturePercent: [Double]! = [69.96, 25.36, 4.68]
    
    
//    var listError: NSMutableArray!
    
    var viewHeight: CGFloat!
    
//    var indicatorView: KQIndicatorView!
    
    var isScan: Bool!
    var isLog: Bool!
    
    
    var numberButton: MDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Tổng quan"
        
        let backItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-link"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KQMainView.showLink))
        backItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = backItem
        
//        self.listError = NSMutableArray()
        
        self.isScan = false
        self.isLog = false
        
        self.setHiddenSize()
        
        
        self.viewHeight = (KQSize.Height() - KQSize.HiddenHeight() - 6 * KQSize.Space())/8
        
//        self.drawIndicator()
        self.drawView()
        
//        self.getLogFile("khcnbackan.gov.vn")
//        
//        self.updatePieChart()
        
//        self.getLogContent("dantri.com.vn")
        
    }
    
    
//    func updatePieChart() {
//        let tempPercent: [Double] = [36.0, 43.0, 21.0]
//        
//        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//        dispatch_async(dispatch_get_global_queue(priority, 0)) {
//            sleep(5)
//            dispatch_async(dispatch_get_main_queue()) {
//                self.setPieChartData(self.postureStyle, values: tempPercent)
//                self.statusView.stopAnimation()
//                self.statusView.statusImage.image = UIImage(named: "icon-status")
//                self.statusView.statusLabel.text = "Quét thành công!"
//            }
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func drawIndicator() {
//        self.indicatorView = KQIndicatorView(frame: CGRectMake(0, 0, KQSize.Width(), KQSize.Height()))
//        self.indicatorView.parentViewController = self
//    }
    
    func getLogContent(weblink: String) {
        if !KQNetwork.reachNetwork().isReachable() {
            KQData.showToast("Vui lòng bật WiFi hoặc 3G!")
            return
        }
        
        if self.isScan == true {
            KQData.showToast("Hệ thống đang thực hiện tác vụ. Vui lòng đợi!")
            return
        }
        
//        self.indicatorView.startAnimation()
        self.statusView.statusLabel.text = "Đang lấy log ..."
        self.statusView.startAnimation()
        self.isLog = true
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            KQPouletServer.getLogContent(weblink) { (error, data) in
                if error != nil {
                    self.isLog = false
                    print("Error: \(error)")
                    sleep(3)
                    dispatch_async(dispatch_get_main_queue()) {
//                        self.indicatorView.stopAnimation()
                        self.statusView.stopAnimation()
                        self.statusView.statusImage.image = UIImage(named: "icon-status-wrong")
                        self.statusView.statusLabel.text = "..."
                    }
                } else {
                    let decodedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Log: \(decodedString!)")
                    
                    self.isLog = false
                    self.getLogFromData(data!)
                    
                    sleep(3)
                    dispatch_async(dispatch_get_main_queue()) {
//                        self.indicatorView.stopAnimation()
                        self.statusView.stopAnimation()
                        self.statusView.statusImage.image = UIImage(named: "icon-status")
                        self.statusView.statusLabel.text = "Lấy log thành công!"
                    }
                }
            }
        }
    }
    
    func getLogFromData(data: NSData) {
        let json = JSON(data: data)
        let logContent = json["log"].string
        
        KQData.setLog(logContent!)
        
        self.showLogView()
    }
    
    func getErrorStatistic(weblink: String) {
        if !KQNetwork.reachNetwork().isReachable() {
            KQData.showToast("Vui lòng bật WiFi hoặc 3G!")
            return
        }
        
        if self.isScan == true {
            KQData.showToast("Hệ thống đang thực hiện tác vụ. Vui lòng đợi!")
            return
        }
        
        
        KQData.showToast("Vui lòng đợi!\nViệc quét một trang web có thể mất khoảng 5 phút hoặc lâu hơn.")
        
        self.statusView.statusLabel.text = "Đang quét ..."
        self.statusView.startAnimation()
        self.isScan = true
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            KQPouletServer.getErrorStatic(weblink) { (error, data) in
                if error != nil {
                    self.isScan = false
                    print("Error: \(error)")
                    sleep(5)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.statusView.stopAnimation()
                        self.statusView.statusImage.image = UIImage(named: "icon-status-wrong")
                        self.statusView.statusLabel.text = "..."
                    }
                } else {
                    self.isScan = false
                    
                    let decodedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Log: \(decodedString!)")
//                    KQData.setLog()
                    sleep(5)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.initializeListError(data!)
                        self.statusView.stopAnimation()
                        self.statusView.statusImage.image = UIImage(named: "icon-status")
                        self.statusView.statusLabel.text = "Quét thành công!"
                    }
                }
            }
        }
    }
    
    func initializeListError(data: NSData) {
        let json = JSON(data: data)
        let dangerousErrors = json["dangerousErrors"].double! * 100
//        self.listError.addObject(dangerousErrors!)
        
        let insignifiantErrors = json["undefinedErrors"].double! * 100
//        self.listError.addObject(insignifiantErrors!)
        
        let highSecurity = json["insignificantErrors"].double! * 100
//        self.listError.addObject(highSecurity!)
        
        var errorPercent: [Double]
        if highSecurity == 0 {
            errorPercent = [dangerousErrors, insignifiantErrors]
            self.setPieChartData(self.postureTwoStyle, values: errorPercent)
            
        } else {
            errorPercent = [dangerousErrors, insignifiantErrors, highSecurity]
            self.setPieChartData(self.postureThreeStyle, values: errorPercent)
        }
        
        let totalError = json["totalErrors"].int
        
        self.numberButton.setTitle("\(totalError!)", forState: .Normal)
    }
    
    func setHiddenSize() {
        let headerHeight: CGFloat = (self.navigationController?.navigationBar.frame.size.height)! + 20
        let footerHeight: CGFloat = (self.tabBarController?.tabBar.frame.size.height)!
        
        KQSize.setHiddenHeight(headerHeight + footerHeight)
        KQSize.setHeaderHeight(headerHeight)
        KQSize.setFooterHeight(footerHeight)
    }
    
    func drawView() {
        let spaceX: CGFloat = KQSize.Space()
        let spaceY: CGFloat = KQSize.Space()
        
        
        self.numberButton = MDButton(frame: CGRectMake(KQSize.Width() - self.viewHeight * 0.8 - spaceX,  KQSize.HeaderHeight() + spaceX, self.viewHeight * 0.8, self.viewHeight * 0.8), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.numberButton.setTitle("", forState: .Normal)
        self.numberButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.numberButton.backgroundColor = OB_COLOR
        self.view.addSubview(self.numberButton)
        
        self.pieChart = PieChartView(frame: CGRectMake(spaceX, spaceY + KQSize.HeaderHeight(), KQSize.Width() - 2 * spaceX, self.viewHeight * 4))
        self.pieChart.delegate = self
        self.pieChart.legend.enabled = false
        self.pieChart.descriptionText = ""
        self.pieChart.holeColor = OB_COLOR
        self.pieChart.holeRadiusPercent = 0.25
//        self.pieChart.centerText = "20"
//        let textAttribute = NSDictionary(objects: [UIFont.boldSystemFontOfSize(20), UIColor.whiteColor()], forKeys: [NSFontAttributeName, NSForegroundColorAttributeName])
//        self.pieChart.centerAttributedText = textAttribute
        
        self.pieChart.transparentCircleColor = UIColor.clearColor()
        
        self.view.addSubview(self.pieChart)
        
        self.setPieChartData(self.postureThreeStyle, values: self.posturePercent)
        
//        self.errorTable = UITableView(frame: CGRectMake(0, spaceY, KQSize.Width(), self.viewHeight * 3 + KQSize.HeaderHeight() + spaceX))
//        self.errorTable.dataSource = self
//        self.errorTable.delegate = self
//        self.errorTable.backgroundColor = UIColor.clearColor()
//        self.errorTable.separatorStyle = UITableViewCellSeparatorStyle.None
//        self.errorTable.scrollEnabled = false
//        self.view.addSubview(self.errorTable)

        
        self.statusView = KQStatusView(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 2 * spaceY + self.viewHeight * 4, KQSize.Width() - 2 * spaceX, self.viewHeight))
//        self.statusView.startAnimation()
        self.view.addSubview(self.statusView)
            
        
        self.scanButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 3 * spaceY + self.viewHeight * 5, KQSize.Width() - 2 * spaceX, self.viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.scanButton.setTitle("Quét Website", forState: .Normal)
        self.scanButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.scanButton.backgroundColor = OB_COLOR
        self.scanButton.addTarget(self, action: #selector(KQMainView.scanWebsite), forControlEvents: .TouchDown)
        self.view.addSubview(self.scanButton)
        
        self.calendarButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 4 * spaceY + self.viewHeight * 6, KQSize.Width() - 2 * spaceX, self.viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.calendarButton.setTitle("Xem log", forState: .Normal)
        self.calendarButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.calendarButton.backgroundColor = OB_COLOR
        self.calendarButton.addTarget(self, action: #selector(KQMainView.checkWeblink), forControlEvents: .TouchDown)
        self.view.addSubview(self.calendarButton)
        
        self.contactButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 5 * spaceY + self.viewHeight * 7, KQSize.Width() - 2 * spaceX, self.viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.contactButton.setTitle("Trợ giúp", forState: .Normal)
        self.contactButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.contactButton.backgroundColor = OB_COLOR
        self.contactButton.addTarget(self, action: #selector(KQMainView.contactSupport), forControlEvents: .TouchDown)
        self.view.addSubview(self.contactButton)
    }
    
    func setPieChartData(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Thống kê lỗi")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
//        pieChartDataSet.valueLinePart1OffsetPercentage = 0.0
//        pieChartDataSet.valueLinePart1Length = 0.0
//        pieChartDataSet.valueLinePart2Length = 0.0
//        pieChartDataSet.xValuePosition = .OutsideSlice
        pieChartDataSet.valueLineColor = UIColor.whiteColor()
        //        pieChartDataSet.yValuePosition = .OutsideSlice
        
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        let chartFormatter: NSNumberFormatter = NSNumberFormatter()
        chartFormatter.numberStyle = .PercentStyle
        chartFormatter.maximumFractionDigits = 1
        chartFormatter.multiplier = 1.0
        chartFormatter.percentSymbol = "%"
        pieChartData.setValueFormatter(chartFormatter)
        pieChartData.setValueFont(UIFont.italicSystemFontOfSize(12.0))
        pieChartData.setValueTextColor(UIColor.whiteColor())
        
        
        self.pieChart.data = pieChartData
        
        self.pieChart.animate(xAxisDuration: 1.5, easingOption: .EaseOutBack)
    }
    
    func updatePieChartData() {
        var values: [ChartDataEntry] = [ChartDataEntry]()
        values.append(ChartDataEntry(value: 10, xIndex: 0))
        values.append(ChartDataEntry(value: 20, xIndex: 1))
        values.append(ChartDataEntry(value: 30, xIndex: 2))
        values.append(ChartDataEntry(value: 40, xIndex: 3))
        
        
        let dataSet = PieChartDataSet(yVals: values, label: "Time Learning")
        dataSet.sliceSpace = 2.0
        
        
        let colors: NSMutableArray = NSMutableArray()
        
        //        colors.addObjectsFromArray(ChartColorTemplates.vordiplom())
        //        colors.addObjectsFromArray(ChartColorTemplates.joyful())
        //        colors.addObjectsFromArray(ChartColorTemplates.colorful())
        //        colors.addObjectsFromArray(ChartColorTemplates.liberty())
        colors.addObjectsFromArray(ChartColorTemplates.pastel())
        
        //        [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        
        
        dataSet.colors = colors as! [NSUIColor]
        
        //        dataSet.valueLinePart1OffsetPercentage = 0.8
        //        dataSet.valueLinePart1Length = 0.2
        //        dataSet.valueLinePart2Length = 0.4
        ////        dataSet.xValuePosition = .OutsideSlice
        //        dataSet.yValuePosition = .OutsideSlice
        
        
        var dataSets: [IChartDataSet] = [IChartDataSet]()
        dataSets.append(dataSet)
        
        let data: PieChartData = PieChartData()
        data.dataSets = dataSets
        
        
        let pieFormatter: NSNumberFormatter = NSNumberFormatter()
        pieFormatter.numberStyle = .PercentStyle
        pieFormatter.maximumFractionDigits = 1
        pieFormatter.multiplier = 1.0
        pieFormatter.percentSymbol = " %"
        data.setValueFormatter(pieFormatter)
        data.setValueFont(UIFont.italicSystemFontOfSize(12.0))
        data.setValueTextColor(UIColor.whiteColor())
        
        self.pieChart.data = data
        
        self.pieChart.highlightValues(nil)
    }
    
    func scanWebsite() {
        let weblink: String = KQConfigure.DictConfig().objectForKey(CFG_WEB_LINK) as! String
        
        if weblink == "nil" {
            KQData.showToast("Vui lòng nhập địa chỉ Website!")
        } else {
            self.getErrorStatistic(weblink)
        }
        
        return
    }
    
    func showLogView() {
        let logView = KQLogView()
        self.navigationController?.pushViewController(logView, animated: true)
        
        
    }
    
    func checkWeblink() {
        let weblink: String = KQConfigure.DictConfig().objectForKey(CFG_WEB_LINK) as! String
        
        if weblink == "nil" {
            KQData.showToast("Vui lòng nhập địa chỉ Website!")
        } else {
            self.getLogContent(weblink)
        }
    }
    
    func contactSupport() {
        KQShare().shareEmail("Nhờ trợ giúp!", content: "", recipers: ["quockhai.vn@gmail.com"]) { (mail) in
            mail.mailComposeDelegate = self
            self.presentViewController(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true) {
            self.view.reloadInputViews()
            self.view.setNeedsDisplay()
        }
    }
    
    func showLink() {
        let timePopup = PopupController.create(self)
        
        //        timePopup.scrollable = false
        //        timePopup.tappable = false
        //        timePopup.movesAlongWithKeyboard = true
        
        let timeView = KQLinkPopup()
        timeView.viewDidLoad()
        timeView.setTimeHandler = { _ in
            
            if timeView.linkText.text?.isEmpty == true {
                KQData.showToast("Địa chỉ website không được để trống!")
                return
            }
            
            
            KQConfigure.DictConfig().setObject(timeView.linkText.text!, forKey: CFG_WEB_LINK)
            KQFileHandle.writeConfigure(KQConfigure.DictConfig())
            
            self.getErrorStatistic(timeView.linkText.text!)
            timePopup.dismiss()
        }
        
        timePopup.show(timeView)
    }
    
    
    
}

extension KQMainView: ChartViewDelegate {
    func chartValueNothingSelected(chartView: ChartViewBase) {
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
    }
    
    func chartTranslated(chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
    
    func chartScaled(chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
}

//extension KQMainView: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return self.viewHeight
//    }
//    
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var numberError: String = ""
//        
//        if self.listError.count > 0 {
//            numberError = "\(self.listError.objectAtIndex(indexPath.row))"
//        }
//        
//        
//        
//        let cell = KQErrorCell(style: .Default, reuseIdentifier: "errorCell")
//        cell.iconNumber.setTitle(numberError, forState: .Normal)
//        
//        switch indexPath.row {
//        case 0:
//            cell.title.text = "Lỗi rất nguy hiểm"
//            cell.lblColor.backgroundColor = UIColor.flatRedColor()
//            cell.iconNumber.backgroundColor = UIColor.flatRedColor()
//            break
//            
//        case 1:
//            cell.title.text = "Lỗi nguy hiểm"
//            cell.lblColor.backgroundColor = UIColor.flatOrangeColor()
//            cell.iconNumber.backgroundColor = UIColor.flatOrangeColor()
//            break
//            
//        case 2:
//            cell.title.text = "Lỗi khác"
//            cell.lblColor.backgroundColor = UIColor.flatBlueColor()
//            cell.iconNumber.backgroundColor = UIColor.flatBlueColor()
//            break
//            
//        default:
//            cell.lblColor.backgroundColor = UIColor.flatPlumColorDark()
//            break
//        }
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        let iSolution: KQSolution = self.listError.objectAtIndex(indexPath.row) as! KQSolution
//        
////        KQData.setCurrentItem(iSolution)
//        
//    }
//    
//}








