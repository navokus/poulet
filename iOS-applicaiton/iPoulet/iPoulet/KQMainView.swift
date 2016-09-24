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

class KQMainView: UIViewController, MFMailComposeViewControllerDelegate {

//    var errorTable: UITableView!
    
//    var errorOneView: KQErrorView!
//    var errorTwoView: KQErrorView!
//    var errorThreeView: KQErrorView!
    
    var pieChart: PieChartView!
    var scanButton: MDButton!
    var calendarButton: MDButton!
    var contactButton: MDButton!
    
    var postureStyle: [String]! = ["Rất nguy hiểm", "Nguy hiểm", "Cơ bản"]
    var posturePercent: [Double]! = [69.96, 25.36, 4.68]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Tổng quan"
        
        let backItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-link"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KQMainView.showLink))
        backItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = backItem
        
        self.setHiddenSize()
        
        self.drawView()
        
        KQPouletServer.getLogFile("dantri.com.vn") { (error, data) in
            if error != nil {
                print("Error: \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let viewHeight: CGFloat = (KQSize.Height() - KQSize.HiddenHeight() - 5 * spaceY)/8
        
        
        self.pieChart = PieChartView(frame: CGRectMake(spaceX, spaceY + KQSize.HeaderHeight(), KQSize.Width() - 2 * spaceX, viewHeight * 5))
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
        
        self.setPieChartData(self.postureStyle, values: self.posturePercent)
        
        self.scanButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 2 * spaceY + viewHeight * 5, KQSize.Width() - 2 * spaceX, viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.scanButton.setTitle("Quét Website", forState: .Normal)
        self.scanButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.scanButton.backgroundColor = OB_COLOR
        self.scanButton.addTarget(self, action: #selector(KQMainView.scanWebsite), forControlEvents: .TouchDown)
        self.view.addSubview(self.scanButton)
        
        self.calendarButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 3 * spaceY + viewHeight * 6, KQSize.Width() - 2 * spaceX, viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
        self.calendarButton.setTitle("Xem log", forState: .Normal)
        self.calendarButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        self.calendarButton.backgroundColor = OB_COLOR
        self.calendarButton.addTarget(self, action: #selector(KQMainView.showLogView), forControlEvents: .TouchDown)
        self.view.addSubview(self.calendarButton)
        
        self.contactButton = MDButton(frame: CGRectMake(spaceX, KQSize.HeaderHeight() + 4 * spaceY + viewHeight * 7, KQSize.Width() - 2 * spaceX, viewHeight), type: .FloatingAction, rippleColor: UIColor.whiteColor())
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
        return
    }
    
    func showLogView() {
        let logView = KQLogView()
        self.navigationController?.pushViewController(logView, animated: true)
        
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
            
            if timeView.txtTime.text?.isEmpty == true {
                KQData.showToast("Thời gian học không được để trống")
                return
            }
            
            
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







