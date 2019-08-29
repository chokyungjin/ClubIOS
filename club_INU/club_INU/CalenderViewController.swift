//
//  CallenderViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 11..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit     // IOS App의 UI를 구현하고, 이벤트를 관리하는 프레임 워크
import FSCalendar   //Pod의 FSCalendar 프레임워크 임포트 -> 캘린더 사용하기위해
import RealmSwift   //Pod의 RealmSwift 프레임워크 임포트 -> DB 연동하기 위해

class CalenderViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate, UIGestureRecognizerDelegate {
    //테이블 뷰를 사용하기위해 DataSource 와 TableViewDelegate 상속. 반드시 구현해야하는 메소드가 있다.
    //뷰컨트롤러와 제스처인식 델리게이트 상속.

    @IBOutlet weak var calTable: UITableView!   //캘린더 테이블갯수 변수 설정
    @IBOutlet weak var calendar: FSCalendar!    //캘린더 객체 변수 설정
    
    
//    var realm: Realm!
//    var arrayData: Results<eventList>?
    var arrayData: [eventList]? //DB의 생성된 클래스 만큼의 배열 크기선언.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calTable.delegate = self    //로드시 처리해야할 객체를 calTable로 지정,위임
        calTable.dataSource = self  //datasource도 calTable로 지정,위임
        
        calTable.tableFooterView = UIView() //테이블의 footerView를 UIView()로 설정
        
//        calTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setupafter loading the view.
        
//        realm = try! Realm()
//        arrayData = realm.objects(eventList.self).sorted(byKeyPath: "eventnum")
        

        calendar.clipsToBounds = true   //테두리(구분선)는 잘리게 설정.

        self.calendar.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)  //이벤트의 디폴트 색 지정
        
        arrayData = DBManager.shared.getEventList(date: Date())
        //선언한 배열에서 Date의 데이터의 리스트를 가져온다.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = arrayData?.count {
            print(count)
            return count    //필수로 준수해야하는 메소드, Row가 몇개인지 설정해줌.
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
        //table의 높이 설정.
    }
    
    //필수로 준수해야하는 메소드, Row마다 해당하는 셀에 들어가는 데이터 설정.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CalendarTableViewCell
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
//FSCalendar 오픈소스를 사용 하기위해 extension
extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //특정 날짜가 선택되었을때, 발생하는 이벤트 처리 메소드
        self.arrayData = DBManager.shared.getEventList(date: date)  //arrayData의 데이터는 DBManager에서 뽑아온다.
//        print(arrayData)
        DispatchQueue.main.async {  //메인스레드에서 비동기로 처리
            self.calTable.reloadData()      //calTable의 전체데이터를 가져온다.
        }
    }
    
    //Event의 개수반환, 0일때는 return 0 . 
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if DBManager.shared.getEventCount(for: date) == 0 {
            return 0
        }
        return 1
    }
}

