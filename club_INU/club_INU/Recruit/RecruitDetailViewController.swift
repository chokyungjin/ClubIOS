//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 조경진 on 04/07/2019.
//  Copyright © 2019 조경진. All rights reserved.
//

import UIKit
import Toast_Swift

class RecruitDetailViewController: UIViewController  {
    
  
    struct tmp {
        static var tmplink: String = ""
    }
    
    @IBOutlet var DetailTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var cruit: Smallregister?
    let sport: UIImage = UIImage(named: "label3")!
    let religion: UIImage = UIImage(named: "label1")!
    let culture: UIImage = UIImage(named: "label2")!
    let bongsa: UIImage = UIImage(named: "label6")!
    let hobby: UIImage = UIImage(named: "label5")!
    let study: UIImage = UIImage(named: "label4")!

    @IBAction func revise(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let deleteAlert = UIAlertController(title: "삭제 확인", message: "게시글을 완전히 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title:"삭제하기",style: .destructive, handler: {
            result in
            
            deleteAlert.addAction(UIAlertAction(title:"확인",style: .default, handler: {
                result in
                
                if self.cruit?.name == CellModel.CellTemp.getCellData().name {
                    
                    Smallregister.dummyRegisterList.removeAll(where: {$0.name == CellModel.CellTemp.getCellData().name} )
                }
                
//                            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NaviRecruit") as? NavigationViewController {
//                                //self.view.makeToast("삭제되었습니다!")
//                                self.navigationController?.show(vc, sender: Any?.self)
//                                //self.present(vc, animated: true, completion: nil)
//                            }
                self.navigationController?.popViewController(animated: true)

            }))
            
            deleteAlert.addAction(UIAlertAction(title:"취소",style: .cancel, handler: {
                result in
                
            }))
            self.present(deleteAlert,animated: true,completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title:"수정하기",style: .destructive, handler: {
            result in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RecruitOkViewController") as! RecruitOkViewController
            
            print(String(self.cruit!.content))
            
            vc.loadView()
            vc.memoText.text = String(self.cruit!.content)
            vc.timeText.text = String(self.cruit!.insertDate)
            vc.nameText.text = String(self.cruit!.name)
            vc.emailText.text = String(self.cruit!.link)
            
            vc.countText.text! = String(describing: Int(self.cruit!.count))
            
            
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))

        alert.addAction(UIAlertAction(title:"취소하기",style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    @IBAction func linkBut(_ sender: Any) {
        self.view.makeToast("링크로 가면 됨.")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "linkView") as? PopUpLinkViewController {
            
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        titleLabel.text = CellModel.CellTemp.getCellData().name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)   //뷰가 사라지기전에 네비게이션 바 숨김
        DetailTable.reloadData() 
    }
    
    func naviBar() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar()
        DetailTable.dataSource = self
        DetailTable.delegate = self
        DetailTable.tableHeaderView = UIView()
    }
}

extension RecruitDetailViewController: UITableViewDataSource ,UITableViewDelegate  {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as!
            DetailTableView
        
        print(cruit!.category,cruit!.name,cruit!.link,cruit!.content,cruit!.count)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        switch cruit!.category {
        case "스포츠" :
            cell.category.setImage(sport, for: UIControlState.normal)
        case "종교" :
            cell.category.setImage(religion, for: UIControlState.normal)
        case "문화" :
            cell.category.setImage(culture, for: UIControlState.normal)
        case "봉사" :
            cell.category.setImage(bongsa, for: UIControlState.normal)
        case "취미/전시" :
            cell.category.setImage(hobby, for: UIControlState.normal)
        case "학술/교양" :
            cell.category.setImage(study, for: UIControlState.normal)
        default: break
            
        }
        cell.contentText.text = cruit!.content
        cell.MaxCount = cruit!.count
        tmp.tmplink = cruit!.link
        print(cell.MaxCount)
        cell.contentText.layer.cornerRadius = 5
        cell.contentText.layer.borderWidth = 1.0
        cell.contentText.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        
            return cell
        }
    
    
}
