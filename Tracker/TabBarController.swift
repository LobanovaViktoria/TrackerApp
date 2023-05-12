//
//  TabBarController.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 26.04.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()        
    }
    
    private func generateTabBar() {
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha:0.2).cgColor
        tabBar.clipsToBounds = true
    }
}
