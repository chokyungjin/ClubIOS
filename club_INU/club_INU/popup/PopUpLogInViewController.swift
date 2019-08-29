//
//  PopUpLogInViewController.swift
//  club_INU
//
//  Created by 조경진 on 09/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift
class PopUpLogInViewController: UIViewController {
        
    @IBAction func loginGo(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation") as? NavigationViewController {
            
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
