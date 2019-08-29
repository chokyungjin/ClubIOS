//
//  ClubMake3ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 24..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
//import SwiftyJSON

class ClubUpdateViewController: UIViewController, UITextFieldDelegate , UITextViewDelegate {

    @IBOutlet weak var clubContent: UITextView! //텍스트뷰
    @IBOutlet weak var clubUrl: UITextField!    //텍스트 입력하는 필드
    @IBOutlet weak var clubPresident: UITextField!  //텍스트 입력하는 필드
    @IBOutlet weak var clubPresidentNum: UITextField!   //텍스트 입력하는 필드
    
    var primarykey = Int()  //PK 인트형 선언
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //델리게이트 위임
    var clubInfo : [Contact] = []   //contact형 배열 선언
    

    var gradientLayer: CAGradientLayer! //그라데이션 해주기위한 변수 선언
    func createGradientLayer() {    //그라데이션 생성 메소드
        gradientLayer = CAGradientLayer()   //객체 생성
        
        gradientLayer.frame = self.view.bounds  //프레임은 자신의 뷰 바운드로 설정
        //그라데이션 from - to 설정
        gradientLayer.colors = [UIColor(red: 97.0 / 255.0, green: 144.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor,
                                UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0 , blue: 232.0 / 255.0, alpha: 1.0).cgColor]
        //그라데이션은 위에서 아래방향으로
        gradientLayer.locations = [0.0, 1.0]
        //그라데이션 배경의 입체도. 다른 뷰와 섞이지않게 -1 로 설정
        gradientLayer.zPosition = -1
        //그라데이션레이어 뷰를 추가
        self.view.layer.addSublayer(gradientLayer)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         clubContent.layer.addBorder([.bottom, .top, .left, .right], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
         clubUrl.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
         clubPresident.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
         clubPresidentNum.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        
        clubContent.delegate = self //델리게이트 위임
        clubUrl.delegate = self     //델리게이트 위임
        clubPresidentNum.delegate = self    //델리게이트 위임
        clubPresident.delegate = self   //델리게이트 위임
        
        clubInfo = DBManager.shared.getClubinfo(num: primarykey)    //PK로 num 찾아 clubinfo 설정
        
        let content = clubInfo[0]["contents"]   //clubinfo의 content 설정
        let phone = clubInfo[0]["phone"]        //clubinfo의 phone 설정
        let url = clubInfo[0]["application"]    //clubinfo의 application 설정
        let masterName = clubInfo[0]["representative"]  //clubinfo의 representative 설정
        if content != nil{
            clubContent.text = "\(content!)"    //nil이 아니면 text 에 넣어줌
        }
        if phone != nil{
            clubPresidentNum.text = "\(phone!)" //nil이 아니면 text 에 넣어줌
        }
        if url != nil{
            clubUrl.text = "\(url!)"    //nil이 아니면 text 에 넣어줌
        }
        if masterName != nil{
            clubPresident.text = "\(masterName!)"   //nil이 아니면 text 에 넣어줌
        }
        
        
        
    
        
       // createGradientLayer()   //메소드 호출
      //  layerview()         //테두리설정하는 메소드 호출
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 텍스트필드 테두리 색
    func layerview() {
        clubUrl.layer.borderColor = UIColor.white.cgColor   //테두리색 설정
        clubPresident.layer.borderColor = UIColor.white.cgColor //테두리색 설정
        clubPresidentNum.layer.borderColor = UIColor.white.cgColor  //테두리색 설정
        clubContent.layer.borderColor = UIColor.white.cgColor   //테두리색 설정
        
        clubUrl.layer.borderWidth = 1.0 //테두리 폭 결정
        clubPresident.layer.borderWidth = 1.0   //테두리 폭 결정
        clubPresidentNum.layer.borderWidth = 1.0    //테두리 폭 결정
        clubContent.layer.borderWidth=1.0   //테두리 폭 결정
    }

    // 텍스트뷰 글자수 제한걸기
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < 200  //200자 미만까지 글자수 제한
    }
    //터치시 편집모드 켜짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //Return 버튼 눌렀을때
        if textField == clubUrl{
            clubPresident.becomeFirstResponder()    //키보드가 나오면서 바로 편집모드
        } else if textField == clubPresident{
            clubPresidentNum.becomeFirstResponder() //키보드가 나오면서 바로 편집모드
        }
        else if textField == clubPresidentNum{
            textField.resignFirstResponder()    //키보드가 나오면서 리턴모드
        }
        return true
    }
    //보내기 버튼
    @IBAction func sendButton(_ sender: Any) {
        let contents = clubContent.text //text 넣어줌
        let application = clubUrl.text  //text 넣어줌
        let representative = clubPresident.text //text 넣어줌
        let phone = clubPresidentNum.text   //text 넣어줌
        
        NetworkManager.shared.updateClub(representative: representative!, phone: phone!, application: application!, contents: contents!){ res in
            if let res = res{   //res 옵셔널 묵시적 해제
                print(res)
            }
            if res == "201"{    //오류
                    self.view.makeToast("수정 실패! 날짜나 시간을 확인하세요!")

            }else {
                
                self.dataUpdate()   //성공시 업데이트
                self.navigationController?.popViewController(animated: true)    //이전 뷰 컨트롤러로 이동
            }
        
        }
    }
    
    func dataUpdate() {
        
        DBManager.shared.deleteAll()
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {
                print(error)
            }
            if let contacts = contacts {
                DBManager.shared.saveContact(array: contacts)
            }
        }
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {
                print(error)
            }
            if let contactsimg = contactsimg{
                DBManager.shared.saveMainImg(array: contactsimg)
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
}
