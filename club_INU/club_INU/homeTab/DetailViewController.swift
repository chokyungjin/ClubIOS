//
//  DetailViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher
import ImageSlideshow
import Toast_Swift


class DetailViewController: UIViewController {

    
//    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubImage: ImageSlideshow!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubLocation: UILabel!
    @IBOutlet weak var clubDetail: UITextView!
    @IBOutlet weak var clubMaster: UILabel!
    
    var getName = String()
    var getUrl = String()
    
    var realm: Realm!
    var arrayData: Results<Contact>!
    let localSource = [ImageSource(imageString: "A")!]
    override func viewDidLoad() {
        super.viewDidLoad()

        clubName.text = getName
        realm = try! Realm()
        let looo = realm.objects(Contact.self).filter("clubname == %@", getName).first?.location
        let master = realm.objects(Contact.self).filter("clubname == %@", getName).first?.representative
        let masternum = realm.objects(Contact.self).filter("clubname == %@", getName).first?.phone
        let cluburl = realm.objects(Contact.self).filter("clubname == %@", getName).first?.application
        let detail = realm.objects(Contact.self).filter("clubname == %@", getName).first?.contents
        let image1 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image1
        let image2 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image2
        let image3 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image3
        let image4 = realm.objects(Contact.self).filter("clubname == %@", getName).first?.image4
        
        
        if cluburl == nil{
            getUrl = ""
        }else {
        getUrl = cluburl!
        }
        if image1 == nil{
            clubImage.setImageInputs(localSource)
        }else if image2 == nil{
            let logo1 = URL(string: "http://inuclub.us.to:3303/\(image1!)")
            let kingfisherSource1 = [KingfisherSource(url: logo1!)]
            clubImage.setImageInputs(kingfisherSource1)
        }else if image3 == nil{
            let logo1 = URL(string: "http://inuclub.us.to:3303/\(image1!)")
            let logo2 = URL(string: "http://inuclub.us.to:3303/\(image2!)")
            let kingfisherSource2 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!)]
            clubImage.setImageInputs(kingfisherSource2)
        }else if image4 == nil{
            let logo1 = URL(string: "http://inuclub.us.to:3303/\(image1!)")
            let logo2 = URL(string: "http://inuclub.us.to:3303/\(image2!)")
            let logo3 = URL(string: "http://inuclub.us.to:3303/\(image3!)")
            let kingfisherSource3 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!),KingfisherSource(url: logo3!)]
            clubImage.setImageInputs(kingfisherSource3)
        }else {
            let logo1 = URL(string: "http://inuclub.us.to:3303/\(image1!)")
            let logo2 = URL(string: "http://inuclub.us.to:3303/\(image2!)")
            let logo3 = URL(string: "http://inuclub.us.to:3303/\(image3!)")
            let logo4 = URL(string: "http://inuclub.us.to:3303/\(image4!)")
            let kingfisherSource4 = [KingfisherSource(url: logo1!), KingfisherSource(url: logo2!),KingfisherSource(url: logo3!),KingfisherSource(url: logo4!)]
            clubImage.setImageInputs(kingfisherSource4)
        }
        slide()
        
//        let popURL = URL(string: cluburl!)
//        print(popURL!)
        
        
        clubLocation.text = looo
        clubDetail.text = detail
        if master == nil || masternum == nil{
            clubMaster.text = "동아리 회장 정보없음"
        }else {
        clubMaster.text = ("\(master!)  \(masternum!)")  //nil 인거 누르면 멈춤
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func URLButton(_ sender: Any) {
        
        if getUrl == "" {
            self.view.makeToast("주소가 없어서 지원할 수 없어요",duration: 3.0, position: .center)
        }else {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "URLPopup") as! PopUpURLViewController
        self.addChildViewController(popOverVC)
        popOverVC.getURL = getUrl
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        }
        
        
        
    }
    
    func slide() { // 이미지 슬라이드
        clubImage.backgroundColor = UIColor.white
        clubImage.slideshowInterval = 3.0
        clubImage.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        clubImage.pageControl.pageIndicatorTintColor = UIColor.black
        clubImage.contentScaleMode = UIViewContentMode.scaleToFill

    }

}
