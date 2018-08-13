//
//  PopUpURLViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift

class PopUpURLViewController: UIViewController {
//    var poppopurl = URL(string: "www.google.com")
    

    var getURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var popupView: UIView!
    
    @IBAction func urlPopup(_ sender: Any) {
        
        if getURL == ""{
            self.view.makeToast("주소가 없어용", duration: 3.0, position: .center)
        }else {
        
        if let converURL = URL(string: getURL){
        UIApplication.shared.open(converURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
