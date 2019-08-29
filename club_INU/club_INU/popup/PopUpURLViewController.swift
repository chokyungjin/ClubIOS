//
//  PopUpURLViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift  //Toast 라이브러리

class PopUpURLViewController: UIViewController {
//    var poppopurl = URL(string: "www.google.com")
    

    var getURL = String()   //string형 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10   //팝업뷰 둥글게 설정
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)//배경색 설정
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var popupView: UIView!   //popupView 선언
    
    //url 버튼 클릭
    @IBAction func urlPopup(_ sender: Any) {
        
        if getURL == ""{    //주소 없으면
            self.view.makeToast("주소가 없어용", duration: 3.0, position: .center)    //토스트
        }else {
        
        if let converURL = URL(string: getURL){ //converURL 옵셔널 바인딩 묵시적 해제 getURL로 링크 열기
        UIApplication.shared.open(converURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.view.removeFromSuperview() //모두 다 닫아줌
    }
    
}
