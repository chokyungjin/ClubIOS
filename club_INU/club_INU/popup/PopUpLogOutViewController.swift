//
//  PopUpLogOutViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class PopUpLogOutViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10   //팝업뷰 둥글게 설정
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)//배경색 설정
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var popupView: UIView!   //popupView 선언
    @IBAction func closePopup(_ sender: Any) {
        self.view.removeFromSuperview() //뷰 전부 지움
    }
    //로그아웃 팝업
    @IBAction func logoutPopup(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController {
//            self.navigationController?.show(vc, sender: nil)
            //tabbar 식별자 찾아서 TabBarViewController로 캐스팅
            UserDefaults.standard.removeObject(forKey: "id")    //id 값 삭제
            UserDefaults.standard.removeObject(forKey: "pass")  //pass 값 삭제
            LoginManager.loginManager.setLogin(isLogin: false)
            //self.dismiss(animated: true, completion: nil)
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
        }
    }
    
}
