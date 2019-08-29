//
//  AlarmSettingViewController.swift
//  club_INU
//
//  Created by 조경진 on 22/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

class AlarmSettingViewController: UITableViewController {
    
    func naviBar() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "알림 설정"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        naviBar()
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
        return 1
        }
        else { return 3}
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "alarmSettingCell") as! AlarmSettingTableViewCell
        if (indexPath.section == 0){
        
        cell.deadlineLabel.text = "투표한 게시글 마감시 알림"
        cell.switch1.isOn = UserDefaults.standard.bool(forKey: "switchState")
        }
        if (indexPath.section == 1){
          let cell = tableView.dequeueReusableCell(withIdentifier: "alarmSettingCell1") as! AlarmSettingTableViewCell2
            cell.label1.text = "댓글 달릴 시 알림"
            cell.switch1.isOn = UserDefaults.standard.bool(forKey: "switchState")
            if (indexPath.row == 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "alarmSettingCell2") as! AlarmSettingTableViewCell4
                cell.label1.text = "마감 하루 전 알림"
                cell.switch1.isOn = UserDefaults.standard.bool(forKey: "switchState")
            }
            if (indexPath.row == 2){
                let cell = tableView.dequeueReusableCell(withIdentifier: "alarmSettingCell3") as! AlarmSettingTableViewCell4
                cell.label1.text = "목표 인원 달성 시 알림"
                cell.switch1.isOn = UserDefaults.standard.bool(forKey: "switchState")
            }
            
        }
        
        
        return cell

    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "투표자"
        }
        else {
            return "게시자"
        }
    }
}
