//
//  DetailViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift   //Realm DB Library
import Kingfisher   //IOS networking Library
import ImageSlideshow   //imageslide Library
import Toast_Swift      //Toast     Library


class DetailViewController: UIViewController {

    
//    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubImage: ImageSlideshow!   //slideShow 생성
    @IBOutlet weak var clubName: UILabel!       //레이블 생성
    @IBOutlet weak var clubLocation: UILabel!   //레이블 생성
    @IBOutlet weak var clubDetail: UITextView!  //텍스트뷰 생성
    @IBOutlet weak var clubMasterNum: UILabel!
    
    @IBOutlet weak var clubMaster: UILabel!     //레이블 생성
    
    var getName = String()  //String형 선언
    var getUrl = String()   //String형 선언
    
    var realm: Realm!   //Realm형  선언 
    var arrayData: Results<Contact>!    //Contact형 구조체 선언
    let localSource = [ImageSource(imageString: "A")!]  //이미지스트링 A인 이미지소스를 넣어 로컬소스 생성
    override func viewDidLoad() {
        super.viewDidLoad()
        //contentScaleMode
        clubName.text = getName //clubName에 text넣어줌
        realm = try! Realm()    //get the default Realm
        //clubName으로 필터링하여 location,representative,phone, application, contents, image1,2,3,4 넣어줌
        let looo = realm.objects(Contact.self).filter("clubname == %@", getName).first?.location
        let master = realm.objects(Contact.self).filter("clubname == %@", getName).first?.representative
        let masternum = realm.objects(Contact.self).filter("clubname == %@", getName).first?.phone
        let cluburl = realm.objects(Contact.self).filter("clubname == %@", getName).first?.application
        let detail = realm.objects(Contact.self).filter("clubname == %@", getName).first?.contents
        let image1 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image1
        let image2 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image2
        let image3 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image3
        let image4 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image4
        
        
        if cluburl == nil{  //clubUrl없으면 ""로설정
            getUrl = ""
        }else {
        getUrl = cluburl!   //있으면 옵셔널 해제하여 넣어줌
        }
        if image1 == nil{   //nil이면 //이미지스트링 A인 이미지소스를 넣어 세트
            clubImage.setImageInputs(localSource)
        }else if image2 == nil{ //nil이면 Kingfisher 이용하여 이미지 세트시켜줌
            let kingfisherSource1 = [KingfisherSource(url: logo1!)]
            clubImage.setImageInputs(kingfisherSource1)
        }else if image3 == nil{ //nil이면 Kingfisher 이용하여 이미지 세트시켜줌
            let kingfisherSource2 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!)]
            clubImage.setImageInputs(kingfisherSource2)
        }else if image4 == nil{ //nil이면 Kingfisher 이용하여 이미지 세트시켜줌
            let kingfisherSource3 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!),KingfisherSource(url: logo3!)]
            clubImage.setImageInputs(kingfisherSource3)
        }else { //nil이면 Kingfisher 이용하여 이미지 세트시켜줌
            let kingfisherSource4 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!),KingfisherSource(url: logo3!),KingfisherSource(url: logo4!)]
            clubImage.setImageInputs(kingfisherSource4)
        }
        slide() //슬라이드 메소드
        
//        let popURL = URL(string: cluburl!)
//        print(popURL!)
        //clubMaster.text = master
        clubMasterNum.text = masternum
        clubLocation.text = looo    //looo를 동아리 장소 텍스트에 넣어줌
        clubDetail.text = detail    //detail을 text에 넣어줌
        if master == nil || masternum == nil{   //회장번호나 회장이름 없으면
            clubMaster.text = "정보없음"
            clubMasterNum.text = "정보없음"
        }else {
        clubMaster.text = ("\(master!)")  //nil 인거 누르면 멈춤
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //지원버튼 클릭
    @IBAction func URLButton(_ sender: Any) {
        
        if getUrl == "" {   //동아리 지원 주소없으면
            self.view.makeToast("주소가 없어서 지원할 수 없어요",duration: 3.0, position: .center)   //Toast
        }else {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            //식별자 주소 URLPopup, PopUpURLViewController로 다운 캐스팅
            "URLPopup") as! PopUpURLViewController
        self.addChildViewController(popOverVC)  //자식뷰 컨트롤러 추가
        popOverVC.getURL = getUrl   //popOverVC에 url주소 넣어줌
        popOverVC.view.frame = self.view.frame  //뷰의 프레임 같게 설정
        self.view.addSubview(popOverVC.view)    //자식 뷰 추가
        popOverVC.didMove(toParentViewController: self) //추가 완료된 이후에는 부모컨트롤러에서 didMove를 호출해줘야함
        }
        
        
        
    }
    
    func slide() { // 이미지 슬라이드
        clubImage.backgroundColor = UIColor.white   //배경색 설정
        clubImage.slideshowInterval = 3.0   //간격 설정
        clubImage.pageControl.currentPageIndicatorTintColor = UIColor.lightGray //현재페이지 표시
        clubImage.pageControl.pageIndicatorTintColor = UIColor.black    //페이지표시
        clubImage.contentScaleMode = .scaleAspectFit    //뷰에 꽉차게 설정


    }

}
