//
//  EventMake1ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 5..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class EventMakeViewController: UIViewController ,UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    let datePickerView:UIDatePicker = UIDatePicker()
    let timePickerView:UIDatePicker = UIDatePicker()
    
    // 배경 그라데이션
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
        
        timePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        dateField.inputView = datePickerView
        timeField.inputView = timePickerView
        
        nameField.delegate = self
        locationField.delegate = self
        dateField.delegate = self
        timeField.delegate = self
//        var selectedDate = datePickerView.date

        layerview()
        createGradientLayer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layerview() {
        timeField.layer.borderColor = UIColor.white.cgColor
        locationField.layer.borderColor = UIColor.white.cgColor
        dateField.layer.borderColor = UIColor.white.cgColor
        nameField.layer.borderColor = UIColor.white.cgColor
        
        dateField.layer.borderWidth = 1.0
        nameField.layer.borderWidth = 1.0
        timeField.layer.borderWidth = 1.0
        locationField.layer.borderWidth = 1.0
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            
            if month <= 9 && day <= 9{
                dateField.text = "\(year)-0\(month)-0\(day)"
            }else if month <= 9 && day >= 10{
                dateField.text = "\(year)-0\(month)-\(day)"
            }else if month >= 10 && day <= 9{
                dateField.text = "\(year)-\(month)-0\(day)"
            }else if month >= 10 && day >= 10{
                dateField.text = "\(year)-\(month)-\(day)"
            }
        }
    }

    @objc func timePickerValueChanged(sender:UIDatePicker) {
        
        let componenets = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        if let hour = componenets.hour, let minute = componenets.minute {
            if hour <= 9 && minute >= 10 {
                timeField.text = "0\(hour):\(minute)"
            }else if hour >= 10 && minute <= 9{
                timeField.text = "\(hour):0\(minute)"
            }else if hour <= 9 && minute <= 9{
                timeField.text = "0\(hour):0\(minute)"
            }else if hour >= 10 && minute >= 10 {
                timeField.text = "\(hour):\(minute)"
            }
        }
    }
    

    @IBAction func sendButton(_ sender: Any) {
        let eventname = nameField.text
        let location = locationField.text
        let date = dateField.text
        let time = timeField.text
        
        NetworkManager.shared.eventMake(eventname: eventname!, date: date!, time: time!, location: location!){ res in
            if let res = res{
                print(res)
            }
            if res == "Created"{
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingHome") as?
//                SettingViewController{
//                    self.navigationController?.show(vc, sender: nil)
                self.dataUpdate()
                self.navigationController?.popViewController(animated: true)
                    self.view.makeToast("행사등록완료")
//                }
            }else {
                self.view.makeToast("에러발생")
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField{
            locationField.becomeFirstResponder()
        } else if textField == locationField{
            textField.resignFirstResponder()
        }
        return true
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
