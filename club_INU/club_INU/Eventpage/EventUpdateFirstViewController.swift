//
//  ClubUpdateFirstViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
//import SwiftyJSON
import Toast_Swift  //toast 라이브러리


class EventUpdateFirstViewController: UIViewController, UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource{
    

    
    @IBOutlet weak var eventName: UITextField!  //행사이름 textField로 설정
    
    var clubName = String()     //String객체 생성
    var eventNumber = String()  //String객체 생성
    let eventnumPicker = UIPickerView() //UIPickerView 객체 생성
    var eventList: [eventList] = [] //eventList 배열 생성
    var pickerRow: [String] = []    //String배열 객체 생성
    var pickerName: [String] = []   //String배열 객체 생성
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //델리게이트 옵셔널 강제 변환
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   layerview() //테두리 설정
         eventName.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        clubName = self.appDelegate.delegateClubname    //델리게이션 위임
        
//        arrayData = realm.objects(eventList.self).filter("clubname == %@", clubName).sorted(byKeyPath: "num")
        eventList = DBManager.shared.getEventList(clubName: clubName)   //eventlist에 clubName으로 필터링한 값 넣어줌
        print(eventList.count)  //출력
        
        for j in 0..<eventList.count{   //이벤트 개수만큼
            var temp = eventList[j]["eventnum"] //eventlist의 num만큼 생성
            pickerRow.append("\(temp!)")    //pickerRow에 추가
            temp = eventList[j]["eventname"]    //name만큼 생성
            pickerName.append("\(temp!)")   //pickerName에 추가
            print(pickerRow)
            print(pickerName)
        }
        eventName.inputView = eventnumPicker    //eventnumPicker를 inputView에 넣어줌

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layerview() {
        eventnumPicker.delegate = self  //델리게이트 위임
        eventnumPicker.dataSource = self    //델리게이트 위임
        eventName.delegate = self       //델리게이트 위임
        eventName.layer.borderColor = UIColor.white.cgColor     //테두리색 설정
        eventName.layer.borderWidth=1.0     //테두리 폭 설정
    }

 
    //컴포넌트의 숫자 리턴 메소드 -> 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //pickerView의  pickerName의 배열원소들 리턴
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerName[row]
    }
    //pickerView의 count리턴
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerName.count
    }
    //선택된 Row의 text와 number리턴
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventName.text = pickerName[row]
        eventNumber = pickerRow[row]
    }
    @IBAction func nextButton(_ sender: Any) {
//        self.appDelegate.delegateEventnum = eventNum.text!
        self.appDelegate.delegateEventnum = eventNumber //델리게이트 위임
        if self.appDelegate.delegateEventnum == "" {    //빈칸이면
            self.view.makeToast("행사 번호를 입력해 주세요!")  //토스트
        }else{
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventUpdate") as? EventUpdateViewController{
            self.navigationController?.show(vc, sender: nil)    //eventUpdate식별자의 뷰 컨트롤러로 이동
            }
//            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventUpdate") as! EventUpdateViewController
//            self.addChildViewController(popOverVC)
//            popOverVC.view.frame = self.view.frame
//            self.view.addSubview(popOverVC.view)
//            popOverVC.didMove(toParentViewController: self)
        }
        
    }
    

}




