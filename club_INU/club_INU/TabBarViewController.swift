//
//  TabBarViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 13..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {    //UITabBarController 상속

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 162.0/255.0, blue: 146.0/255.0, alpha: 1)
        self.tabBar.itemSpacing = UIScreen.main.bounds.width / 6
        //탭바의 외형결정. appearance()는 Pod의 FSCalendar 참조하여 탭바 색깔 지정.
        //탭바 아이템의 간격 설정 -> 메인스토리 보드의 간격의 1/6 로 설정.
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
