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
        popupView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var popupView: UIView!
    @IBAction func closePopup(_ sender: Any) {
        self.view.removeFromSuperview()
    }

    @IBAction func logoutPopup(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController {
//            self.navigationController?.show(vc, sender: nil)
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
