//
//  ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018var. 11..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import ImageSlideshow   //이미지 슬라이드쇼 보여주는 라이브러리
//import RealmSwift   //DB연동하는 라이브러리
//import SwiftyJSON

class ViewController: UIViewController , UISearchBarDelegate{
    let formatter = DateFormatter() //데이터포메더 객체 생성
    var chose = String()    //String형 객체 생성
    var mainImg: [KingfisherSource] = []    //킹피셔 소스형 배열 생성
    
    @IBOutlet weak var scrollView: UIScrollView!    //스크롤뷰 생성
    
    //스포츠 선택 버튼
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func sportButton(_ sender: Any) {
        chose = "스포츠"
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as?
                ListViewController {
                vc.click = chose
                self.navigationController?.show(vc, sender: nil)
            }
    }
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func religionButton(_ sender: Any) {
        chose = "종교"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func cultureButton(_ sender: Any) {
        chose = "문화"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func serviceButton(_ sender: Any) {
        chose = "봉사"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func hobbyButton(_ sender: Any) {
        chose = "취미전시"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    //ListView식별자로 이동, //vc의 click에 chose넣어주고 이동
    @IBAction func studyButton(_ sender: Any) {
        chose = "교양학술"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBOutlet weak var label: UILabel!          //레이블 선언
    @IBOutlet weak var search: UISearchBar!     //검색바 선언
    @IBOutlet weak var slideshow: ImageSlideshow!   //이미지슬라이드 선언
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self      //델리게이트 위임

        // Do any additional setup after loading the view, typically from a nib.
        //slide()
        navigationColor()   //네비게이션바 색깔 지정
        search.setImage(UIImage(named: "symbol"), for: .search, state: .normal)
        search.placeholder="Search"
        search.barTintColor = UIColor.white //바 색깔 지정
        search.layer.borderWidth=1.0        //폭 지정
        search.layer.borderColor = UIColor.white.cgColor    //테두리 색깔 지정
//        search.layer.backgroundColor = UIColor.red.cgColor
//        print(dateFormatterr.string(from: dateFormatterr.date(from: time)!)
        
        
        DBManager.shared.deleteAll()    //DB내용 전부 지워줌
        
        // realm 파일 주소
        print("Realm 주소!")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {  //error 옵셔널 바인딩 해제
                print(error)
            }
            if let contacts = contacts {    //contact 옵셔널 바인딩 해제
                DBManager.shared.saveContact(array: contacts)   //DB에 저장
                //                DispatchQueue.main.async {
                //                    // UI 작업
                //                    self.tableView.reloadData()
                //                }
            }
        }
        
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {  //error 옵셔널 바인딩 해제
                print(error)
            }
            if let contactsimg = contactsimg{   //contactsimg 옵셔널 바인딩 해제
                DBManager.shared.saveMainImg(array: contactsimg)    //DB에 저장
                var img = DBManager.shared.getMainImg()
                //메인 Img들 불러옴
                let count = img.count   //이미지 개수 저장
                for j in 0..<count{ //count 개수만큼
                    let imgString = img[j]["img"]   //imgString에 넣어줌
                    self.mainImg.append(KingfisherSource(url:URL(string:"Private/\(imgString!)")!)) //URL주소에서 가져오는 이미지를 추가함
                }
        
                self.slideshow.setImageInputs(self.mainImg) //메인이미지를 세트함
            }
           
        }
        
        NetworkManager.shared.getContactsEventList{ contactsevent, error in
            if let error = error {  //error 옵셔널 바인딩 해제
                print(error)
            }
            if let contactsevent = contactsevent {  //contactsevent 옵셔널 해제
                DBManager.shared.saveEventList(array: contactsevent)    //eventlist 추가
                
                print(contactsevent, "event")
            }
        }
    }
    

//    func slide () { // 이미지 슬라이드
//        slideshow.backgroundColor = UIColor.white
//        slideshow.slideshowInterval = 5.0
//        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
//        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
//        slideshow.contentScaleMode = .scaleAspectFit
////        slideshow.setImageInputs(localSource)
//
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
//        slideshow.addGestureRecognizer(recognizer)
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @objc func didTap() {   //메인 이미지 탭 했을경우
        let fullScreenController = slideshow.presentFullScreenController(from: self)    //현재 스크린지정
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        //활성화되면 밑에 점이 하얀색으로 바뀜 , 디폴트는 색깔없음
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
    
    // 네비 바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)  //뷰가 나타나기전에 네비게이션 바 숨김
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)   //뷰가 사라지기전에 네비게이션 바 숨김
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) //검색바 선택시 이벤트
    {
        let searchClub = search.text    //text 대입
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.searchButton = searchClub!
            //ListView식별자로 이동, //vc의 searchButton에 searchClub넣어주고 이동
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
   
}




