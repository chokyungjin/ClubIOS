//
//  PopUpLinkViewController.swift
//  club_INU
//
//  Created by 조경진 on 09/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
import SafariServices

class PopUpLinkViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBAction func cancelButton(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController {
            
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
        }
    }
    @IBAction func okButton(_ sender: Any) {
        
//        guard let url = URL(string: "http:// google.com"), UIApplication.shared.canOpenURL(url) else { return }
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
     //   RecruitDetailViewController.tmp(tmplink)
        guard let url = URL(string: RecruitDetailViewController.tmp.tmplink ) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(RecruitDetailViewController.tmp.tmplink)
        popUpView.layer.cornerRadius = 10   //팝업뷰 둥글게 설정
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)//배경색 설정

    }
}
