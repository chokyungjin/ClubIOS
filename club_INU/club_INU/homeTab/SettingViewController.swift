//
//  SettingViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit     // IOS App의 UI를 구현하고, 이벤트를 관리하는 프레임 워크
import RealmSwift   ////Pod의 RealmSwift 프레임워크 임포트 -> DB 연동하기 위해

class SettingViewController: UIViewController {
    
    @IBOutlet weak var clubName: UILabel!   //동아리 이름 입력하는 레이블
    
    @IBOutlet weak var createBut: UIButton!
    @IBOutlet weak var makeLabel: UIButton!
    
    @IBAction func logoutButton(_ sender: Any)
    {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logoutPopUp") as! PopUpLogOutViewController
        //logoutPopUp 화면이동 컨트롤러 PopUpLogOutViewController로 다운 캐스팅
        self.addChildViewController(popOverVC)  //popOverVC로 자식컨트롤러 추가.
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)    //자식 뷰 추가
        popOverVC.didMove(toParentViewController: self) //추가 한뒤 부모뷰에서 didMove로 호출해줘야함.
        
    }
    
    @IBAction func clubUpdate(_ sender: Any)
    {
        let primary = Int(self.appDelegate.delegateClubnum) //앱 델리게이트에서 받아온 클럽번호의 숫자를 primary에 저장
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "clubUpdate") as?
            //clubUpdate 화면이동 컨트롤러,ClubUpdateViewController로 다운 캐스팅
            ClubUpdateViewController{
            vc.primarykey = primary!    //vc인스턴스의 primarykey 에 강제옵셔널
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.show(vc, sender: nil)    //해당하는 vc로 이동
        }
    }
    
    @IBAction func alarmSetting(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmSetting") as?
            //clubUpdate 화면이동 컨트롤러,ClubUpdateViewController로 다운 캐스팅
            alarmViewController{
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.show(vc, sender: nil)    //해당하는 vc로 이동
        }
    }
    
    @IBAction func imageUpdate(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "clubImage") as?
            //clubUpdate 화면이동 컨트롤러,ClubImageViewController로 다운 캐스팅

            ClubImageViewController{
            self.navigationController?.show(vc, sender: nil) //해당하는 vc로 이동
        }
        
    }
    
    @IBAction func eventMake(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventMake") as?
            //eventMake 화면이동 컨트롤러,EventMakeViewController로 다운 캐스팅
            EventMakeViewController{
            self.navigationController?.show(vc, sender: nil) //해당하는 vc로 이동
        }
    }
    
    
    @IBAction func eventUpdate(_ sender: Any) {
//        let primary = self.appDelegate.delegateClubname
//        print(primary)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventUpdateFirst") as?
            //eventUpdateFirst 화면이동 컨트롤러,EventUpdateFirstViewController로 다운 캐스팅
            EventUpdateFirstViewController{
//            vc.clubName = primary
            
            self.navigationController?.show(vc, sender: nil) //해당하는 vc로 이동
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //appDelegate를 AppDelegate로 강제 다운캐스팅
    var number = String()   //string 으로 선언
    var realm: Realm!   //Realm객체 선언
    var arrayData: Results<Contact>! //Contact의 클래스의 요소를 담은 Result의 객체들로 이루어진 arrayData배열 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationColor()   // 네비게이션바 투명색으로 만드는 메소드 호출
        
        let clubnum = Int(self.appDelegate.delegateClubnum)
        
        realm = try! Realm()    //get the default Realm
//        let looo = realm.objects(Contact.self).filter("num == %@", clubnum!).first?.clubname
//                clubName.text = looo!
//        //realm객체에서 num으로 필터링
//            self.appDelegate.delegateClubname = looo!   //델리게이트 위임
        
        //UINavigationBar.appearance().barTintColor = UIColor.black //바 배경색 변경
        // Do any additional setup after loading the view.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
  
    //네비바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)  //뷰가 나타나기전에 네비게이션 바 숨김
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)   //뷰가 사라지기전에 네비게이션 바 숨김
    }
    
    
}
