//
//  KQTabBarController.swift
//  EISTI
//
//  Created by QuocKhai on 6/7/16.
//  Copyright © 2016 QuocKhai. All rights reserved.
//

import UIKit

class KQTabBarController: UITabBarController {
    
    class func TabBarController() -> UITabBarController {
        
        let firstView = KQMainView()
        let secondView = KQAnalyseView()
        let thirdView = KQSolutionView()
        let fourthView = KQSettingView()
        
        let firstNavigation: KQNavigationController = KQNavigationController(rootViewController: firstView)
        let secondNavigation: KQNavigationController = KQNavigationController(rootViewController: secondView)
        let thirdNavigation: KQNavigationController = KQNavigationController(rootViewController: thirdView)
        let fourthNavigation: KQNavigationController = KQNavigationController(rootViewController: fourthView)

        let firstTab = UITabBarItem(title: "", image: UIImage(named: "bar-home"), selectedImage: UIImage(named: "bar-home-selected"))
        firstTab.image = firstTab.image?.imageWithRenderingMode(.AlwaysOriginal)
        firstTab.selectedImage = firstTab.selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
        firstTab.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let secondTab = UITabBarItem(title: "", image: UIImage(named: "bar-learn"), selectedImage: UIImage(named: "bar-learn-selected"))
        secondTab.image = secondTab.image?.imageWithRenderingMode(.AlwaysOriginal)
        secondTab.selectedImage = secondTab.selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
        secondTab.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let thirdTab = UITabBarItem(title: "", image: UIImage(named: "bar-posture"), selectedImage: UIImage(named: "bar-posture-selected"))
        thirdTab.image = thirdTab.image?.imageWithRenderingMode(.AlwaysOriginal)
        thirdTab.selectedImage = thirdTab.selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
        thirdTab.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let fourthTab = UITabBarItem(title: "", image: UIImage(named: "icon-setting"), selectedImage: UIImage(named: "icon-setting-selected"))
        fourthTab.image = fourthTab.image?.imageWithRenderingMode(.AlwaysOriginal)
        fourthTab.selectedImage = fourthTab.selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
        fourthTab.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        
        firstNavigation.tabBarItem = firstTab
        secondNavigation.tabBarItem = secondTab
        thirdNavigation.tabBarItem = thirdTab
        fourthNavigation.tabBarItem = fourthTab
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [firstNavigation, secondNavigation, thirdNavigation, fourthNavigation]
        tabbarController.selectedIndex = 0
        tabbarController.tabBar.barTintColor = BD_COLOR

        return tabbarController
    }
    
}

