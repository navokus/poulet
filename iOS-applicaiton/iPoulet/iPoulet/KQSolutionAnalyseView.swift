//
//  KQSolutionAnalyseView.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit
import WebKit

class KQSolutionAnalyseView: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webLink: NSURL!
    
    var indicatorView: KQIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Giải pháp"
        
        let backItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KQSolutionAnalyseView.backView))
        backItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = backItem
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(KQSolutionAnalyseView.shareActivity))
        
        self.drawView()
        
        self.loadLink(webLink)
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        self.drawIndicator()
        self.indicatorView.startAnimation()
    }
    
    func backView() {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            self.progressView.hidden = self.webView.estimatedProgress == 1
            
            if self.webView.estimatedProgress > 0.6 {
                self.indicatorView.stopAnimation()
            }
            progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
        }
    }
    
    func drawIndicator() {
        self.indicatorView = KQIndicatorView(frame: CGRectMake(0, 0, KQSize.Width(), KQSize.Height()))
        self.indicatorView.parentViewController = self
    }
    
    func drawView() {
        self.webView = WKWebView(frame: CGRectMake(0, 0, KQSize.Width(), KQSize.Height()))
        self.webView.backgroundColor = BG_COLOR
        self.view.addSubview(self.webView)
        
        self.progressView = UIProgressView(frame: CGRectMake(0, 0, KQSize.Width(), 2))
        self.progressView.progressViewStyle = UIProgressViewStyle.Bar
        self.webView.addSubview(self.progressView)
    }
    
    func loadLink(link: NSURL) {
        self.webView.loadRequest(NSURLRequest(URL: link))
    }
    
    func shareActivity() {
        
        let string = KQData.CurrentItem()?.title
        let URL: NSURL = NSURL(string: (KQData.CurrentItem()?.link)!)!
        let activityViewController = UIActivityViewController(activityItems: [string!, URL], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
