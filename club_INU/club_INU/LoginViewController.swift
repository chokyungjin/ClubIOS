//
//  LoginViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var errorLael: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 배경 그라데이션 넣기
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
        
        createGradientLayer()
        navigationColor()
        super.viewDidLoad()
        idTextField.delegate = self
        passTextField.delegate = self
        errorLael.text = "로그인을 해 주세요"
        
        if UserDefaults.standard.string(forKey: "id") != nil{
            self.idTextField.text = UserDefaults.standard.string(forKey: "id")
            self.passTextField.text = UserDefaults.standard.string(forKey: "pass")
            loginButton((Any).self)
        }
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    func navigationColor() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
  
    // return 버튼 누르면 꺼지기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField{
            passTextField.becomeFirstResponder()
        } else if textField == passTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let idtext = idTextField.text
        let pwtext = passTextField.text

        NetworkManager.shared.login(id: idtext!, pw: pwtext!) { res in
            if let res = res{
                print(res)
                print(self.appDelegate.delegateClubnum)
            }
            if res == "460"{
                self.errorLael.text = "아이디 또는 비밀번호를 다시 확인해 주세요."
                self.errorLael.textColor = UIColor.red
                self.passTextField.text = ""
                self.view.makeToast("아이디 또는 비밀번호를 다시 확인해 주세요.")
            }else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingHome") as? SettingViewController{
                UserDefaults.standard.set(self.idTextField.text, forKey: "id")
                UserDefaults.standard.set(self.passTextField.text, forKey:"pass")
                UserDefaults.standard.synchronize()
                
                vc.number = res!
                self.navigationController?.show(vc, sender: nil)
                }
            }
    }
    
   }


}
