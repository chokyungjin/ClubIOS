//
//  ClubMakeViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift  //토스트 라이브러리

class EventUpdateViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate{


    @IBOutlet weak var timeField: UITextField!      //TextField로 선언
    @IBOutlet weak var locationField: UITextField!  //TextField로 선언
    @IBOutlet weak var nameField: UITextField!      //TextField로 선언
    @IBOutlet weak var dateField: UITextField!      //TextField로 선언
    @IBOutlet weak var deleteField: UITextField!    //TextField로 선언
    let appDelegate = UIApplication.shared.delegate as! AppDelegate     //강제 캐스팅

    var eventDetail: [eventList] = []   //eventList 배열형 선언

    
    let datePickerView:UIDatePicker = UIDatePicker()    //Date객체선언
    let timePickerView:UIDatePicker = UIDatePicker()    //Date객체선언

    override func viewDidLoad() {
        super.viewDidLoad()
        timePickerView.datePickerMode = UIDatePickerMode.time   //시간 넣어줌
        datePickerView.datePickerMode = UIDatePickerMode.date   //날짜 넣어줌
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        //selector는 datePickerValueChanged
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        //selector는 timePickerValueChanged
        dateField.inputView = datePickerView    //inputView 설정
        timeField.inputView = timePickerView    //inputView 설정
        
        let eventNum:Int = Int(self.appDelegate.delegateEventnum)!  //int형로 캐스팅
        eventDetail = DBManager.shared.getEventDetail(eventNum: eventNum)   //detail에 num으로 필터링한거 넣어줌
        print(eventDetail)
        
        let name = eventDetail[0]["eventname"]  //eventDetail에 eventname 넣어줌
        let location = eventDetail[0]["location"]   //eventDetail에 location 넣어줌
        let date = eventDetail[0]["date"]       //eventDetail에 date 넣어줌
        let time = eventDetail[0]["time"]       //eventDetail에 time 넣어줌
        nameField.text = "\(name!)"         //name 넣어줌
        locationField.text = "\(location!)" //location 넣어줌
        dateField.text = "\(date!)"         //date 넣어줌
        timeField.text = "\(time!)"         //time 넣어줌
        deleteField.text = "\(name!)"       //name 넣어줌
        
        nameField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        locationField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        dateField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        timeField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        deleteField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        

        
    //    layerview()     //테두리색 설정 메소드 호출
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 텍스트필드 테두리 색
    func layerview() {      //테두리 색 설정 메소드
        timeField.layer.borderColor = UIColor.white.cgColor     //테두리 색 설정
        locationField.layer.borderColor = UIColor.white.cgColor //테두리 색 설정
        dateField.layer.borderColor = UIColor.white.cgColor     //테두리 색 설정
        nameField.layer.borderColor = UIColor.white.cgColor     //테두리 색 설정
        
        dateField.layer.borderWidth = 1.0       //테두리 폭 설정
        nameField.layer.borderWidth = 1.0       //테두리 폭 설정
        timeField.layer.borderWidth = 1.0       //테두리 폭 설정
        locationField.layer.borderWidth = 1.0   //테두리 폭 설정
    }
    
   //재 터치시 편집모드 켜짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField{
            locationField.becomeFirstResponder()    //키보드 올라오면서 자동편집
        } else if textField == locationField{
            textField.resignFirstResponder()        //리턴모드로 자동편집
        }
        return true
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        //날짜 바뀌면 쓰는 메소드
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        //현재의 날짜를 보냄 ,year, month , day
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            //옵셔널 바인딩 묵시적 해제 -> day, month, year
            if month <= 9 && day <= 9{
                dateField.text = "\(year)-0\(month)-0\(day)"    //앞에 0 붙여서 두자리 수 만들어줌
            }else if month <= 9 && day >= 10{
                dateField.text = "\(year)-0\(month)-\(day)"     //앞에 0 붙여서 두자리 수 만들어줌
            }else if month >= 10 && day <= 9{
                dateField.text = "\(year)-\(month)-0\(day)"     //앞에 0 붙여서 두자리 수 만들어줌
            }else if month >= 10 && day >= 10{
                dateField.text = "\(year)-\(month)-\(day)"
            }
        }
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker) {
        //시간 바뀌면 쓰는 메소드
        let componenets = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        //현재 시간을 보냄, hour ,minute
        if let hour = componenets.hour, let minute = componenets.minute {   //묵시적 옵셔널 바인딩 해제
            if hour <= 9 && minute >= 10 {
                timeField.text = "0\(hour):\(minute)"       //앞에 0 붙여서 두자리 수 만들어줌
            }else if hour >= 10 && minute <= 9{
                timeField.text = "\(hour):0\(minute)"       //앞에 0 붙여서 두자리 수 만들어줌
            }else if hour <= 9 && minute <= 9{
                timeField.text = "0\(hour):0\(minute)"      //앞에 0 붙여서 두자리 수 만들어줌
            }else if hour >= 10 && minute >= 10 {
                timeField.text = "\(hour):\(minute)"
            }
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let eventname = nameField.text  //text 넣어줌
        let location = locationField.text   //text 넣어줌
        let date = dateField.text       //text 넣어줌
        let time = timeField.text       //text 넣어줌
        
    
        NetworkManager.shared.eventUpdate(eventname: eventname!, date: date!, time: time!, location: location!){ res in
            if let res = res{   //res 옵셔널 해제
                print(res)
            }
            if res == "Created"{    //생성되면
                self.dataUpdate()   //업데이트
                //                self.navigationController?.popViewController(animated: true)
                let switchViewController = self.navigationController?.viewControllers[1] as! SettingViewController
                self.navigationController?.popToViewController(switchViewController, animated: true)
                //switchViewController로 이동
            }else {
                self.view.makeToast("수정 에러")
            }
            
        }
    }
    //삭제 버튼
    @IBAction func deleteButton(_ sender: Any) {
        
        NetworkManager.shared.eventDelete{res in
            if let res = res{     //res 옵셔널 해제
                print(res)
            }
            if res == "Created"{    //생성되면
                self.dataUpdate()   //업데이트
//                self.navigationController?.popViewController(animated: true)
                let switchViewController = self.navigationController?.viewControllers[1] as! SettingViewController
                self.navigationController?.popToViewController(switchViewController, animated: true)                //switchViewController로 이동
            }else {
                self.view.makeToast("삭제 에러")

            }
        }
    }
    //데이터갱신
    func dataUpdate() {
        
        DBManager.shared.deleteAll()    //전체 델리트
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {  //error 옵셔널 해제
                print(error)
            }
            if let contacts = contacts {    //contact 옵셔널 해제
                DBManager.shared.saveContact(array: contacts)   //저장
            }
        }
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {  //error 옵셔널 해제
                print(error)
            }
            if let contactsimg = contactsimg{   //contactsimg 옵셔널 해제
                DBManager.shared.saveMainImg(array: contactsimg)    //저장
            }
        }
        NetworkManager.shared.getContactsEventList{ contactsevent, error in
            if let error = error {  //error 옵셔널 해제
                print(error)
            }
            if let contactsevent = contactsevent {  //contactsevent 옵셔널 해제
                DBManager.shared.saveEventList(array: contactsevent)    //저장
                
                print(contactsevent, "event")
            }
        }
    }

}
