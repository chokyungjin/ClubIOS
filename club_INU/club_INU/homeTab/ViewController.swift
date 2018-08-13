//
//  ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018var. 11..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import ImageSlideshow
import RealmSwift
//import SwiftyJSON

class ViewController: UIViewController , UISearchBarDelegate{
    let formatter = DateFormatter()
    var chose = String()
    var mainImg: [KingfisherSource] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func sportButton(_ sender: Any) {
        chose = "스포츠"
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
                vc.click = chose
                self.navigationController?.show(vc, sender: nil)
            }
    }
    @IBAction func religionButton(_ sender: Any) {
        chose = "종교"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBAction func cultureButton(_ sender: Any) {
        chose = "문화"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBAction func serviceButton(_ sender: Any) {
        chose = "봉사"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBAction func hobbyButton(_ sender: Any) {
        chose = "취미전시"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBAction func studyButton(_ sender: Any) {
        chose = "교양학술"
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.click = chose
            self.navigationController?.show(vc, sender: nil)
        }
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var slideshow: ImageSlideshow!
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        slide()
        navigationColor()
        search.barTintColor = UIColor.white
        search.layer.borderWidth=1.0
        search.layer.borderColor = UIColor.white.cgColor
//        search.layer.backgroundColor = UIColor.red.cgColor
//        print(dateFormatterr.string(from: dateFormatterr.date(from: time)!)
        
        
        DBManager.shared.deleteAll()
        
        // realm 파일 주소
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {
                print(error)
            }
            if let contacts = contacts {
                DBManager.shared.saveContact(array: contacts)
                //                DispatchQueue.main.async {
                //                    // UI 작업
                //                    self.tableView.reloadData()
                //                }
            }
        }
        
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {
                print(error)
            }
            if let contactsimg = contactsimg{
                DBManager.shared.saveMainImg(array: contactsimg)
                let img = DBManager.shared.getMainImg()
                let count = img.count
                for j in 0..<count{
                    let imgString = img[j]["img"]
                    self.mainImg.append(KingfisherSource(url:URL(string:"http://inuclub.us.to:3303/\(imgString!)")!))
                }
                self.slideshow.setImageInputs(self.mainImg)
            }
        }
        
        NetworkManager.shared.getContactsEventList{ contactsevent, error in
            if let error = error {
                print(error)
            }
            if let contactsevent = contactsevent {
                DBManager.shared.saveEventList(array: contactsevent)
                
                print(contactsevent, "event")
            }
        }
    }
    

    func slide() { // 이미지 슬라이드
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 3.0
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
//        slideshow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    func navigationColor() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
    // 네비 바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let searchClub = search.text
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListViewController {
            vc.searchButton = searchClub!
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
   
}




