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

    @IBOutlet weak var clubContent: UITextView!
    @IBOutlet weak var clubUrl: UITextField!
    @IBOutlet weak var clubPresident: UITextField!
    @IBOutlet weak var clubPresidentNum: UITextField!
    
    var primarykey = Int()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var clubInfo : [Contact] = []
    

    var gradientLayer: CAGradientLayer!
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red: 97.0 / 255.0, green: 144.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor,
                                UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0 , blue: 232.0 / 255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.zPosition = -1
        self.view.layer.addSublayer(gradientLayer)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubContent.delegate = self
        clubUrl.delegate = self
        clubPresidentNum.delegate = self
        clubPresident.delegate = self
        
        clubInfo = DBManager.shared.getClubinfo(num: primarykey)
        
        let content = clubInfo[0]["contents"]
        let phone = clubInfo[0]["phone"]
        let url = clubInfo[0]["application"]
        let masterName = clubInfo[0]["representative"]
        if content != nil{
            clubContent.text = "\(content!)"
        }
        if phone != nil{
            clubPresidentNum.text = "\(phone!)"
        }
        if url != nil{
            clubUrl.text = "\(url!)"
        }
        if masterName != nil{
            clubPresident.text = "\(masterName!)"
        }
        
    
        
        createGradientLayer()
        layerview()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 텍스트필드 테두리 색
    func layerview() {
        clubUrl.layer.borderColor = UIColor.white.cgColor
        clubPresident.layer.borderColor = UIColor.white.cgColor
        clubPresidentNum.layer.borderColor = UIColor.white.cgColor
        clubContent.layer.borderColor = UIColor.white.cgColor
        
        clubUrl.layer.borderWidth = 1.0
        clubPresident.layer.borderWidth = 1.0
        clubPresidentNum.layer.borderWidth = 1.0
        clubContent.layer.borderWidth=1.0
    }

    // 텍스트뷰 글자수 제한걸기
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < 200
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //Return 버튼 눌렀을때
        if textField == clubUrl{
            clubPresident.becomeFirstResponder()
        } else if textField == clubPresident{
            clubPresidentNum.becomeFirstResponder()
        }
        else if textField == clubPresidentNum{
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let contents = clubContent.text
        let application = clubUrl.text
        let representative = clubPresident.text
        let phone = clubPresidentNum.text
        
        NetworkManager.shared.updateClub(representative: representative!, phone: phone!, application: application!, contents: contents!){ res in
            if let res = res{
                print(res)
            }
            if res == "201"{
                    self.view.makeToast("수정 실패 날짜나 시간을 확인하세요")

            }else {
                
                self.dataUpdate()
                self.navigationController?.popViewController(animated: true)
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
