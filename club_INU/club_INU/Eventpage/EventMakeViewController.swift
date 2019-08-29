//
//  EventMake1ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 5..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class EventMakeViewController: UIViewController ,UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var nameField: UITextField!  //TextField로 설정
    @IBOutlet weak var locationField: UITextField!  //TextField로 설정
    @IBOutlet weak var dateField: UITextField!  //TextField로 설정
    @IBOutlet weak var timeField: UITextField!  //TextField로 설정
    
    let datePickerView:UIDatePicker = UIDatePicker()    //데이트피커로 객체 선언
    let timePickerView:UIDatePicker = UIDatePicker()    //데이트피커로 객체 선언
    @IBOutlet weak var sendButton: UIButton!
    var count: Int = 0
    
    func validate1(text: String) -> Bool {
        return text != ""
    }
    func validate2(text: String) -> Bool {
        return text != ""
    }
    func validate3(text: String) -> Bool {
        return text != ""
    }
    @IBAction func titleChanged(_ sender: UITextField) {
        if validate1(text: sender.text!){
            count += 1
        }
    }
    @IBAction func locationChanged(_ sender: UITextField) {
        if validate2(text: sender.text!){
            count += 1
        }
        
    }
    @IBAction func dateChanged(_ sender: UITextField) {
        if validate3(text: sender.text!){
            count += 1
        }
    }
  
    @IBAction func timeChanged(_ sender: UITextField) {
        if validate3(text: sender.text!){
            count += 1
        }
        if (count == 4){
            sendButton.backgroundColor = UIColor(red: 255.0 / 255.0, green: 162.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
            sendButton.isEnabled = true
        }
    }

    
        func naviBar() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
            self.navigationItem.title = "행사등록"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        sendButton.isEnabled = false
        
        
        super.viewDidLoad()
        naviBar()
    
        timeField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        dateField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        locationField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        nameField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        
        timePickerView.datePickerMode = UIDatePickerMode.time   //시간 넣어줌
        datePickerView.datePickerMode = UIDatePickerMode.date   //날짜 넣어줌
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        //selector는 datePickerValueChanged
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        //selector는 timePickerValueChanged
        dateField.inputView = datePickerView    //inputView 설정
        timeField.inputView = timePickerView    //inputView 설정
        
        nameField.delegate = self       //델리게이트 위임
        locationField.delegate = self   //델리게이트 위임
        dateField.delegate = self       //델리게이트 위임
        timeField.delegate = self       //델리게이트 위임
//        var selectedDate = datePickerView.date

     //   layerview() //테두리색 설정 메소드
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
   
    
    
    //보내기 버튼
    @IBAction func sendBut(_ sender: Any) {
        
        
        let eventname = nameField.text  //text 입력
        let location = locationField.text   //text 입력
        let date = dateField.text   //text 입력
        let time = timeField.text   //text 입력
        //이벤트 생성
        NetworkManager.shared.eventMake(eventname: eventname!, date: date!, time: time!, location: location!){ res in
            if let res = res{   //res 옵셔널 해제
                print(res)
            }
            if res == "Created"{    //생성되면
                //                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingHome") as?
                //                SettingViewController{
                //                    self.navigationController?.show(vc, sender: nil)
                self.dataUpdate()   //업데이트
                self.navigationController?.popViewController(animated: true)    //이전 뷰 컨트롤러로 이동
                self.view.makeToast("행사등록완료")   //Toast
                //                }
            }else {
                self.view.makeToast("에러발생") //Toast
            }
            
        }
    }
    //재터치시 편집모드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField{
            locationField.becomeFirstResponder()    //키보드 자동 편집모드
        } else if textField == locationField{
            textField.resignFirstResponder()    //키보드 리턴모드
        }
        return true
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

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


