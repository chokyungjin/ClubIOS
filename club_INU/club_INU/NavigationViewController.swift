//
//  NavigationViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 3. 17..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController { //네비게이션 컨트롤러 사용할예정.
    var number = String()   //string 으로 선언

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
   //     naviBar()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func navigationColor() { //네비게이션 투명색만들기
        //투명하게 만드는 공식처럼 기억하기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //네비게이션바의 백그라운드색 지정. UIImage와 동일
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //shadowImage는 UIImage와 동일. 구분선 없애줌.
        self.navigationController?.navigationBar.isTranslucent = true
        //false면 반투명이다.
        self.navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        //뷰의 배경색 지정
    }
    
    func naviBar() {
        //네비게이션 컨트롤러에서 large title  켜기 true면 좀 밑으로 내려감
        navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationController?.navigationBar.shadowImage = #imageLiteral(resourceName: "bg")
        self.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()


    }

}


