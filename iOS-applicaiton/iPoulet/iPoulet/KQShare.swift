//
//  KQShare.swift
//  DidomOnline
//
//  Created by QuocKhai on 4/30/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit
import Social

class KQShare: NSObject {

    class func shareFacebook(content: String, completionHandler: (facebook: SLComposeViewController) -> Void){
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//            facebookShare.setInitialText(content)
            facebookShare.title = content
            facebookShare.addURL(NSURL(string: APP_LINK))
            
            completionHandler(facebook: facebookShare)
        } else {
            KQData.showToast("Connecter votre compte Facebook pour partager!\nS'il vous plaît!")
        }
    }
    
    class func shareFacebook(content: String, link: String, completionHandler: (facebook: SLComposeViewController) -> Void){
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            //            facebookShare.setInitialText(content)
            facebookShare.title = content
            facebookShare.addURL(NSURL(string: link))
            
            completionHandler(facebook: facebookShare)
        } else {
            KQData.showToast("Connecter votre compte Facebook pour partager!\nS'il vous plaît!")
        }
    }
    
    class func shareTwitter(content: String, completionHandler: (twitter: SLComposeViewController) -> Void) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterShare.setInitialText(content)
            twitterShare.addURL(NSURL(string: APP_LINK))
            
            completionHandler(twitter: twitterShare)
        } else {
            KQData.showToast("Connecter votre compte Twitter pour partager!\nS'il vous plaît!")
        }
    }
    
    class func shareTwitter(content: String, link: String, completionHandler: (twitter: SLComposeViewController) -> Void) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterShare.setInitialText(content)
            twitterShare.addURL(NSURL(string: link))
            
            completionHandler(twitter: twitterShare)
        } else {
            KQData.showToast("Connecter votre compte Twitter pour partager!\nS'il vous plaît!")
        }
    }
    
    func shareEmail(title: String, content: String, completionHandler: (mail: MFMailComposeViewController) -> Void) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients([])
            mail.setSubject("[Poulet] " + title)
            mail.setMessageBody(content, isHTML: false)
            
            completionHandler(mail: mail)
        } else {
            KQData.showToast("Connecter votre compte émail pour partager!\nS'il vous plaît!")
        }
    }
    
    func shareEmail(title: String, content: String, recipers: [String], completionHandler: (mail: MFMailComposeViewController) -> Void) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(recipers)
            mail.setSubject("[Poulet] " + title)
            mail.setMessageBody(content, isHTML: false)
            
            completionHandler(mail: mail)
        } else {
            KQData.showToast("Connecter votre compte émail pour partager!\nS'il vous plaît!")
        }
    }
    
    func shareMessage(content: String, completionHandler: (message: MFMessageComposeViewController) -> Void) {
        if MFMessageComposeViewController.canSendText() {
            let message = MFMessageComposeViewController()
            message.recipients = []
            message.body = content
            
            completionHandler(message: message)
        } else {
            KQData.showToast("Votre appareil ne peut pas envoyer un message!")
        }
    }
    
}
