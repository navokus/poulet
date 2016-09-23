//
//  KQAnalyseView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import Charts

class KQAnalyseView: UIViewController {

    var barChart: BarChartView!
    var recommandTextView: UITextView!
    
    var weekDays: [String]! = ["03/16", "04/16", "05/16", "06/16", "07/16", "08/16", "09/16"]
    var learnTime: [Double]! = [10.0, 8.0, 12.0, 12.0, 6.0, 15.0, 17.0]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Thống kê"
        
        self.drawView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView() {
        let spaceX: CGFloat = KQSize.Space()
        let spaceY: CGFloat = KQSize.Space()
        
        let viewHeight: CGFloat = (KQSize.Height() - KQSize.HiddenHeight() - 3 * spaceY)/8
        
        self.barChart = BarChartView(frame: CGRectMake(spaceX, spaceY + KQSize.HeaderHeight(), KQSize.Width() - 2 * spaceX, viewHeight * 5))
        self.barChart.delegate = self
        self.barChart.noDataText = "You need to provide data for the chart."
        self.barChart.legend.enabled = false
        self.barChart.descriptionText = ""
        //        self.barChart.gridBackgroundColor = UIColor.whiteColor()
        self.barChart.xAxis.labelTextColor = UIColor.whiteColor()
        self.barChart.leftAxis.labelTextColor = UIColor.whiteColor()
        self.barChart.rightAxis.labelTextColor = UIColor.whiteColor()
        self.view.addSubview(self.barChart)
        
        self.setBarChartData(self.weekDays, values: self.learnTime)
        
        self.recommandTextView = UITextView(frame: CGRectMake(spaceX, 2 * spaceY + KQSize.HeaderHeight() + viewHeight * 5, KQSize.Width() - 2 * spaceX, viewHeight * 3))
        self.recommandTextView.backgroundColor = OB_COLOR
        self.recommandTextView.textColor = UIColor.whiteColor()
        self.recommandTextView.textAlignment = .Left
        self.recommandTextView.layer.cornerRadius = 5.0
        self.recommandTextView.layer.masksToBounds = true
        self.recommandTextView.font = UIFont.italicSystemFontOfSize(16.0)
        self.recommandTextView.text = "Hệ thống cần được nâng cấp lên phiên bản mới nhất cho các công cụ sau: ..."
        self.recommandTextView.editable = false

        self.view.addSubview(self.recommandTextView)
    }

    func setBarChartData(dataPoints: [String], values: [Double]) {
        
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Số lượng lỗi")
        let chartData = BarChartData(xVals: self.weekDays, dataSet: chartDataSet)
        
        let chartFormatter: NSNumberFormatter = NSNumberFormatter()
        chartFormatter.numberStyle = .DecimalStyle
        chartFormatter.maximumFractionDigits = 1
        chartFormatter.multiplier = 1.0
        chartFormatter.percentSymbol = ""
        chartData.setValueFormatter(chartFormatter)
        chartData.setValueFont(UIFont.systemFontOfSize(12.0))
        chartData.setValueTextColor(UIColor.whiteColor())
        
        self.barChart.data = chartData
        
        self.barChart.descriptionText = ""
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        self.barChart.xAxis.labelPosition = .Bottom
        
        //        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        self.barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        
        
//        let limitLine = ChartLimitLine(limit: 10.0, label: "Mục tiêu")
//        limitLine.valueTextColor = UIColor.whiteColor()
//        limitLine.valueFont = UIFont.boldSystemFontOfSize(12.0)
//        self.barChart.rightAxis.addLimitLine(limitLine)
    }
    
    
}

extension KQAnalyseView: ChartViewDelegate {
    func chartValueNothingSelected(chartView: ChartViewBase) {
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
    }
    
    func chartTranslated(chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
    
    func chartScaled(chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
}

