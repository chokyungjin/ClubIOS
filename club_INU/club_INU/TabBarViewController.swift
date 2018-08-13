//
//  TabBarViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 13..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 162/255, blue: 146/255, alpha: 1)
        self.tabBar.itemSpacing = UIScreen.main.bounds.width / 6
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
