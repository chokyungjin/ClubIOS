//
//  AlarmTableViewController.swift
//  club_INU
//
//  Created by 조경진 on 12/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift

class AlarmTableViewController: UITableViewController {

    @IBOutlet var alarmTable: UITableView!
    var arrayData: [eventList]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrayData = DBManager.shared.getTempEventList()
        
        //arrayData의 데이터는 DBManager에서 뽑아온다.
             //   print(arrayData!)
        print([eventList]?.self)

        
        DispatchQueue.main.async {  //메인스레드에서 비동기로 처리
            print("로드되었습니다.")
            self.alarmTable.reloadData()      //calTable의 전체데이터를 가져온다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       self.arrayData = DBManager.shared.getEventList(date: Date())
      //arrayData의 데이터는 DBManager에서 뽑아온다.
        //        print(arrayData)
//        DispatchQueue.main.async {  //메인스레드에서 비동기로 처리
//            print("로드되었습니다.")
        //    self.alarmTable.reloadData()      //calTable의 전체데이터를 가져온다.
        

        alarmTable.delegate = self
        alarmTable.dataSource = self
      
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        //table의 높이 설정.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = arrayData?.count {
        return count    //필수로 준수해야하는 메소드, Row가 몇개인지 설정해줌.
    }
    return 0
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as! AlarmTableViewCell
        //재사용디큐 사용 식별자는 CalendarCell , CalendarTableViewCell로 강제 캐스팅
        //        let dateFormat = DateFormatter()
        //        let datecal = dateFormat.string(from: arrayData[indexPath.row].date!)
        //        print(datecal)
        //        cell.dayLabel.text = dateFormat.string(from: arrayData[indexPath.row].date!)
        
        if let array = arrayData { //옵셔널 체크 및 값 할당
            
            let item = array[indexPath.row] //item에 array의 row크기 만큼의 인덱스 설정.
            cell.eventNameLabel.text = item.eventname //셀의 이벤트이름 텍스트에는 item의 이벤트이름
            cell.timeLabel.text = "시간: " + item.time    //셀의 시간 텍스트에는 item의 시간
            cell.locationLabel.text = "장소: " + item.location    //셀의 장소 텍스트에는 item의 장소
            cell.dayLabel.text = item.clubname      //셀의 날짜 텍스트에는 item의 동아리이름
            
        }
        
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //셀의 엣지를 0,0,0,0으로 설정하여 꽉차게 설정.
        
        
        return cell
        
    }

    




}
