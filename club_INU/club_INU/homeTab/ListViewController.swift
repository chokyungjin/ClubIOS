//
//  ListViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 26..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit        //UI관련된 컴포넌트를 쓰기위해 라이브러리 추가
import RealmSwift   //Pod의 RealmSwift 프레임워크 임포트 -> DB 연동하기 위해
import Kingfisher   //Pod의 IOS의 네트워킹 관련 라이브러리

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//테이블 구현하기위해 테이블 델리게이트, 데이터 소스 상속
    
    @IBOutlet weak var tableView: UITableView!  //테이블 뷰 생성
    var realm: Realm!   //Realm형 생성
    var arrayData: Results<Contact>!    //Contact형 구조체 선언
    var click = String()        //String형 선언
    var searchButton = String() //String형 선언
    
    
    override func viewDidLoad() {
        
        //createGradientLayer()   //그라데이션 함수 호출

        super.viewDidLoad()
        navigationItem.searchController?.searchBar.delegate = self      //델리게이트 위임
        
        //get the default Realm
        realm = try! Realm()
        if click == "" {
            //쿼리문 clubname, category로 찾기, 정렬은 num으로
            arrayData = realm.objects(Contact.self).filter("clubname CONTAINS %@ || category CONTAINS %@", searchButton,searchButton).sorted(byKeyPath: "num")
            //검색결과를 보여줌
            self.navigationItem.title = "\(searchButton) 검색결과"
        }else {
            //쿼리문 category 로 찾기, 정렬은 num으로
               arrayData = realm.objects(Contact.self).filter("category == %@", click).sorted(byKeyPath: "num")
            //검색결과를 보여줌
            self.navigationItem.title = click
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

            
            
        }
        
        
        naviBar()   //largetitle 켜기
        tableView.reloadData()  //데이터 불러오기

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count  //테이블 개수 리턴
        

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210  //셀의 높이 지정
    }
    //cell안에 넣을 데이터 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
      //  gradientLayer.locations = [0.0, 1.0]
        //
        //        //그라데이션 배경의 입체도. 다른 뷰와 섞이지않게 -1 로 설정
        //        gradientLayer.zPosition = -1
        //        self.view.layer.addSublayer(gradientLayer)  //그라데이션레이어를 뷰에 추가.
        //
        cell.ClubName.text = arrayData[indexPath.row].clubname  //row의 clubname 데이터 셀에 넣어줌
        
        
        cell.ClubLocation.text = arrayData[indexPath.row].location  //row의 location 데이터 셀에 넣어줌

//        cell.ClubImage.layer.masksToBounds = tr
//        cell.ClubImage.layer.cornerRadius = 2.0
//        cell.ClubImage.layer.masksToBounds = false
//        cell.ClubImage.layer.borderWidth = 1.0
        cell.ClubImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        cell.ClubImage.layer.zPosition = -1
        
        //셀의 테두리색 설정
        
        //row의 이미지1이 nil이 아니라면
        if arrayData[indexPath.row].image1 != nil{
            let logo = "Private/\(arrayData[indexPath.row].image1!)"
            //logo에 배열에있는 이미지1 넣어줌
            print(logo,"logo")  //로고 출력
            let loogo = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            //URL에서 이미지 다운받음
            cell.ClubImage.kf.setImage(with: loogo) //loogo로 이미지 세트
        } else {
            cell.ClubImage.image = #imageLiteral(resourceName: "invalidName-1") // 없으면 디폴트 이미지로 넣어줌
        }
        //셀의 좌측 시작점 지정
       // cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cell.layer.cornerRadius = 30
       // self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.separatorStyle = .none

        return cell //셀 리턴
    }
    

    //테이블에서 셀 선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as?
            //식별자 DetailView를 찾음
            DetailViewController{
            vc.getName = arrayData[indexPath.row].clubname  //row의 clubname을 찾아줌
            self.navigationController?.show(vc, sender: nil)    //해당하는 vc로 이동
        }
        let cell = tableView.cellForRow(at: indexPath)  //indexpath 경로설정
        cell?.isSelected = false    //선택되면 false
    }
   
    
    func naviBar() {
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "iconsDarkBack")?.withRenderingMode(.alwaysTemplate)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage =  UIImage(named: "iconsDarkBack")?.withRenderingMode(.alwaysTemplate)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //네비게이션바의 백그라운드색 지정. UIImage와 동일
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //shadowImage는 UIImage와 동일. 구분선 없애줌.
        self.navigationController?.navigationBar.isTranslucent = true
        //false면 반투명이다.
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        
      
        //        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.searchController?.searchBar.text
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let searchClub = navigationItem.searchController?.searchBar.text
//    }
}
