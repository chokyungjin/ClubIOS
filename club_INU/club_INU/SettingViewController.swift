//
//  SettingViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController {
    
    @IBOutlet weak var clubName: UILabel!
    
    @IBAction func logoutButton(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logoutPopUp") as! PopUpLogOutViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    @IBAction func clubUpdate(_ sender: Any) {
        let primary = Int(self.appDelegate.delegateClubnum)
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "clubUpdate") as? ClubUpdateViewController{
            vc.primarykey = primary!
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    @IBAction func imageUpdate(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "clubImage") as? ClubImageViewController{
            self.navigationController?.show(vc, sender: nil)
        }
        
    }
    
    @IBAction func eventMake(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventMake") as? EventMakeViewController{
//            vc.primarykey = primary!
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    
    @IBAction func eventUpdate(_ sender: Any) {
//        let primary = self.appDelegate.delegateClubname
//        print(primary)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventUpdateFirst") as? EventUpdateFirstViewController{
//            vc.clubName = primary
            
            self.navigationController?.show(vc, sender: nil)
        }

    }
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var number = String()
    var realm: Realm!
    var arrayData: Results<Contact>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationColor()
        let clubnum = Int(self.appDelegate.delegateClubnum)
        
        realm = try! Realm()
        let looo = realm.objects(Contact.self).filter("num == %@", clubnum!).first?.clubname
                clubName.text = looo!
            self.appDelegate.delegateClubname = looo!
        
        UINavigationBar.appearance().barTintColor = UIColor.black //바 배경색 변경
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func navigationColor() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(0.0)
    }
    
    //네비바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    
}
