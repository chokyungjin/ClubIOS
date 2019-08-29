//
//  RecruitOkViewController.swift
//  club_INU
//
//  Created by 조경진 on 05/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

class RecruitOkViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {


    
    lazy var pickerView: UIPickerView = { // Generate UIPickerView.
        let picker = UIPickerView() // Specify the size.
     //   picker.frame = CGRect(x: 0, y: 150, width: self.view.bounds.width, height: 180.0)
        picker.backgroundColor = .lightGray
        picker.delegate = self
        picker.dataSource = self
        return picker }()
     let values: [String] = ["5","10","15","20","25","30"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
        
    } // A method called when the picker is selected.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(values[row])")
        countText.text! = values[row]
    }
    
   
    
    var count : String!
    @IBOutlet var memoText: UITextView!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var timeText: UITextField!
    @IBOutlet weak var countText: UITextField!
    @IBOutlet weak var categoryText: UITextField!
    
    let datePickerView:UIDatePicker = UIDatePicker()    //데이트피커로 객체 선언
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameText{
            memoText.becomeFirstResponder()    //키보드 자동 편집모드
        }
        if textField == memoText{
            emailText.becomeFirstResponder()    //키보드 자동 편집모드
        }
        if textField == emailText{
            countText.becomeFirstResponder()    //키보드 자동 편집모드
        }
        if textField == countText{
            timeText.becomeFirstResponder()    //키보드 자동 편집모드
        }
        if textField == timeText{
            textField.resignFirstResponder()    //키보드 리턴모드
        }
        return true
    }
  
    @IBAction func checkBox(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""

        } else {
            sender.isSelected = true
              categoryText.text!  = "스포츠"
        }
    }
    @IBAction func checkBox2(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""
        } else {
            sender.isSelected = true
            categoryText.text!  = "종교"
        }
    }
    @IBAction func checkBox3(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""
        } else {
            sender.isSelected = true
            categoryText.text!  = "문화"
        }
    }
    
    @IBAction func checkBox4(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""
        } else {
            sender.isSelected = true
            categoryText.text!  = "봉사"
        }
    }
    @IBAction func checkBox5(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""
        } else {
            sender.isSelected = true
            categoryText.text!  = "취미/전시"
        }
    }
    
    @IBAction func checkBox6(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            categoryText.text!  = ""
        } else {
            sender.isSelected = true
            categoryText.text!  = "교양/학술"
        }
    }
    @IBAction func registerButton(_ sender: Any) {
        
        let memo = memoText.text!
        if (memo == ""){
            self.view.makeToast("내용을 입력해주세요!")
        }
        let categorydetail = categoryText.text!
        if (categorydetail == ""){
            self.view.makeToast("카테고리를 입력해주세요!")
        }
        let tmpemail = emailText.text!
        if (tmpemail == ""){
            self.view.makeToast("주소를 입력해주세요!")
        }
        let tmpname = nameText.text!
        if (tmpname == ""){
            self.view.makeToast("제목을 입력해주세요!")
        }
        let tmptime = timeText.text!
        if (tmptime == ""){
            self.view.makeToast("마감시간을 입력해주세요!")
        }
        let tmpcount = Float(countText.text!)
        if (tmpcount == 0){
            self.view.makeToast("충족인원을 입력해주세요!")
        }
        
        if (memo != "" && categorydetail != "" && tmpemail != "" && tmpname != "" && tmptime != "" && tmpcount != 0){
            
        let newCruit = Smallregister(category:  categorydetail,content: memo , name: tmpname ,link: tmpemail,insertDate: tmptime,count: tmpcount!)
            
            Smallregister.dummyRegisterList.append(newCruit)
            print(newCruit.category,newCruit.name,newCruit.link,newCruit.content,newCruit.insertDate,newCruit.count)
        }
        UserDefaults.standard.set(self.memoText.text, forKey: "memo")
        UserDefaults.standard.set(self.categoryText.text, forKey: "categorydetail")
        UserDefaults.standard.set(self.emailText.text, forKey: "tmpemail")
        UserDefaults.standard.set(self.nameText.text, forKey: "tmpname")
        UserDefaults.standard.set(self.timeText.text, forKey: "tmptime")
        UserDefaults.standard.set(self.countText.text, forKey: "tmpcount")
        //let aUser: String = UserDefaults.standard.object(forKey: "memo") as! String
        
        //showToast(message: "모집이 등록되었습니다.")
        
         if (memo != "" && categorydetail != "" && tmpemail != "" && tmpname != "" && tmptime != "" && tmpcount != 0){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Recruit") as? RecruitViewController {
            
            self.show(vc, sender: Any?.self)
            // 식별자 가르키는 곳으로 이동
        }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        emailText.layer.cornerRadius = 5
        nameText.layer.cornerRadius = 5
        timeText.layer.cornerRadius = 5
        countText.layer.cornerRadius = 5
        memoText.layer.cornerRadius = 5
        memoText.layer.masksToBounds = true
        datePickerView.datePickerMode = UIDatePickerMode.date   //날짜 넣어줌
        
        self.memoText.layer.borderWidth = 1.0
        self.memoText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.emailText.layer.borderWidth = 1.0
        self.emailText.layer.borderColor = UIColor.lightGray.cgColor
        self.nameText.layer.borderWidth = 1.0
        self.nameText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.timeText.layer.borderWidth = 1.0
        self.timeText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.countText.layer.borderWidth = 1.0
        self.countText.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBOutlet weak var regist: UIButton!
    
    
    override func viewDidLoad() {
                
        navigationColor()   //메소드 호출

        emailText.layer.cornerRadius = 5
        nameText.layer.cornerRadius = 5
        timeText.layer.cornerRadius = 5
        countText.layer.cornerRadius = 5
        memoText.layer.cornerRadius = 5
        memoText.layer.masksToBounds = true
      
        self.memoText.layer.borderWidth = 1.0
         self.memoText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.emailText.layer.borderWidth = 1.0
         self.emailText.layer.borderColor = UIColor.lightGray.cgColor
        self.nameText.layer.borderWidth = 1.0
         self.nameText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.timeText.layer.borderWidth = 1.0
         self.timeText.layer.borderColor = UIColor.lightGray.cgColor
        
        self.countText.layer.borderWidth = 1.0
         self.countText.layer.borderColor = UIColor.lightGray.cgColor
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        //pickerView.addSubview(countText.inputView!)

        timeText.inputView = datePickerView
        countText.inputView = pickerView
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        //날짜 바뀌면 쓰는 메소드
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        
        //현재의 날짜를 보냄 ,year, month , day
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            //옵셔널 바인딩 묵시적 해제 -> day, month, year
            if month <= 9 && day <= 9{
                timeText.text = "\(year)-0\(month)-0\(day)"    //앞에 0 붙여서 두자리 수 만들어줌
            }else if month <= 9 && day >= 10{
                timeText.text = "\(year)-0\(month)-\(day)"     //앞에 0 붙여서 두자리 수 만들어줌
            }else if month >= 10 && day <= 9{
                timeText.text = "\(year)-\(month)-0\(day)"     //앞에 0 붙여서 두자리 수 만들어줌
            }else if month >= 10 && day >= 10{
                timeText.text = "\(year)-\(month)-\(day)"
            }
        }
    }

    func navigationColor() { //네비게이션 투명색만들기
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //네비게이션바의 백그라운드색 지정. UIImage와 동일
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //shadowImage는 UIImage와 동일. 구분선 없애줌.
        self.navigationController?.navigationBar.isTranslucent = true
        //false면 반투명이다.
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
}

extension UIViewController {
    func showToast(message: String){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 25)
        toastLbl.textColor = UIColor.black
        toastLbl.numberOfLines = 0
        let textSize = toastLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 70)
        toastLbl.frame = CGRect(x: 20, y: window.frame.height - 285, width: labelWidth, height: textSize.height)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        let toastImage = UIImageView()
        toastImage.image = #imageLiteral(resourceName: "Checkbox-1")
        toastImage.frame = CGRect(x: 50, y: window.frame.height - 380, width: 60, height: 60)
        toastImage.center.x = window.center.x
        toastImage.layer.cornerRadius = 10
        toastImage.layer.masksToBounds = true
        
        
        let backView = UIView()
        backView.backgroundColor = .white
        backView.frame = CGRect(x: 20, y: window.frame.height - 350, width: 250, height: 141)
        backView.center.x = window.center.x
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .gray
        backView.layer.masksToBounds = true
        
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = .lightGray
//        backgroundView.frame = CGRect(x: 0, y: 0, width: 375, height: 670)
//        backgroundView.center.x = window.center.x
//        backgroundView.layer.zPosition = 0.3

        
        
        window.addSubview(backView)
        window.addSubview(toastLbl)
        window.addSubview(toastImage)
       // window.addSubview(backgroundView)
        
        
        UIView.animate(withDuration: 5.0, animations: {
            
            toastLbl.alpha = 0.3
            backView.alpha = 0.3
            toastImage.alpha = 0.3
           // backgroundView.alpha = 0.3
        }) { (_) in
            toastLbl.removeFromSuperview()
            backView.removeFromSuperview()
            toastImage.removeFromSuperview()
          //  backgroundView.removeFromSuperview()
        }
    }
}

