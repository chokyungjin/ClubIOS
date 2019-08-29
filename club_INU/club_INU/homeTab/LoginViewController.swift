//
//  LoginViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit     // IOS App의 UI를 구현하고, 이벤트를 관리하는 프레임 워크
import Toast_Swift  //안드로이드처럼 Toast를 띄우기 위한 프레임워크
import MTSlideToOpen
class LoginViewController: UIViewController, UITextFieldDelegate {
//뷰컨트롤러와 TextFieldDelegate를 상속.
    
//    lazy var customizeSlideToOpen: MTSlideToOpenView = {
//        let slide = MTSlideToOpenView(frame: CGRect(x: 20, y: 365, width: 335, height: 48))
//        slide.sliderViewTopDistance = 0
//        slide.thumbnailViewTopDistance = 4;
//        slide.thumbnailViewStartingDistance = 4;
//        slide.sliderCornerRadius = 20
//        slide.thumnailImageView.backgroundColor = .white
//        slide.draggedView.backgroundColor = .clear
//        slide.delegate = self
//        slide.defaultLabelText = "Login"
//        slide.thumnailImageView.image = #imageLiteral(resourceName: "그룹 7")
//        slide.defaultSliderBackgroundColor = .lightGray
//        return slide
//    }()
//
    
    
    @IBAction func loginButton(_ sender: Any) {
        let idtext = idTextField.text   //id에 텍스트필드 삽입
        let pwtext = passTextField.text //pw에 텍스트필드 삽입
        
        NetworkManager.shared.signIn(id: idtext!, passwd: pwtext!) { res in
            
            print("res입니다")
            print(res)
            if let res = res{ //res 옵셔널 해제
                print("res입니다")
                print(res)
                print(self.appDelegate.delegateClubnum)
            }
            if res == "400"{    //460이면
             //   self.errorLael.text = "아이디 또는 비밀번호를 다시 확인해 주세요."    //error레이블에 띄워줌
             //   self.errorLael.textColor = UIColor.red  //색깔은 레드
                self.passTextField.text = ""    //패스워드는 초기화
                self.view.makeToast("아이디 또는 비밀번호를 다시 확인해 주세요.") //토스트 출력
            }
           // if res == "200"
            else {//460이 아니면
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as?
                    //if let 구문 묵시적 캐스팅, 화면전환
                    TabBarViewController{
                    UserDefaults.standard.set(self.idTextField.text, forKey: "id")  //UserDefaults에 idtext를 id에 set
                    UserDefaults.standard.set(self.passTextField.text, forKey:"pass")  //UserDefaults에 passtext를 pass에 set
                    
                    UserDefaults.standard.synchronize() // //UserDefaults를 동기화 해줌
                    //  vc.number = res!    //vc의 number에 res를 강제캐스팅
                    LoginManager.loginManager.setLogin(isLogin: true)
                 
                    self.present(vc, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "register") as? RegisterViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBOutlet weak var idTextField: UITextField!    //id입력 필드
    @IBOutlet weak var passTextField: UITextField!  //Pass입력 필드
    @IBOutlet weak var errorLael: UILabel!  //에러발생 레이블
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //appDelegate를 다운캐스팅 변환.
    
   
    @IBAction func laterButton(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController {
            
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
            
        }
    }
    override func viewDidLoad() {
        
//        createGradientLayer()   //메소드 호출
        navigationColor()   //메소드 호출
        super.viewDidLoad()
           idTextField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
           passTextField.layer.addBorder([.bottom], color: UIColor(displayP3Red: 161.0/255.0, green: 191.0/255.0, blue: 232.0/255.0, alpha: 1.0), width: 1.5)
        
        idTextField.delegate = self     //id델리게이트 위임
        passTextField.delegate = self   //pass델리게이트 위임
        //앱에 데이터를 저장해놓기위해 UserDefaults사용
        if UserDefaults.standard.string(forKey: "id") != nil{   //id가 nil이 아니라면
            self.idTextField.text = UserDefaults.standard.string(forKey: "id") //text 넣어줌
            self.passTextField.text = UserDefaults.standard.string(forKey: "pass")  //pass 넣어줌
        }
        
        if (LoginManager.loginManager.getLogin()) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingHome") as? SettingViewController {
                self.navigationController?.show(vc, sender: Any?.self)
        }
    }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    func navigationColor() { //네비게이션 투명색만들기
        //투명하게 만드는 공식처럼 기억하기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //네비게이션바의 백그라운드색 지정. UIImage와 동일
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //shadowImage는 UIImage와 동일. 구분선 없애줌.
        self.navigationController?.navigationBar.isTranslucent = false
        //false면 반투명이다.
        self.navigationController?.view.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        //뷰의 배경색 지정.
    }
  
    // return 버튼 누르면 꺼지기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //return 버튼 누르면 키보드 내려갈수있게 설정.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField{
            passTextField.becomeFirstResponder() // id입력시에는 enter가 화살표 표시로 다음 텍스트 입력으로 이동
        } else if textField == passTextField{
            textField.resignFirstResponder()    //pass입력시에는 enter가 return으로 표시
        }
        return true
    }


}
