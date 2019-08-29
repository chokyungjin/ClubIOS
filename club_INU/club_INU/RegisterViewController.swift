//
//  RegisterViewController.swift
//  club_INU
//
//  Created by 조경진 on 12/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift
class RegisterViewController: UIViewController {
    
    let registerOk: UIImage = UIImage(named: "1307")!
    let registerNotOk: UIImage = UIImage(named: "1306")!

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var pwCheck: UITextField!
    var count : Int = 0
    
    func validate1(text: String) -> Bool {
        return text != ""
    }
    func validate2(text: String) -> Bool {
        return text != ""
    }
    func validate3(text: String) -> Bool {
        return text != ""
    }
    @IBAction func nameChanged(_ sender: UITextField) {
        if validate1(text: sender.text!){
            count += 1
        }
        print(count)
    }
    @IBAction func idChanged(_ sender: UITextField) {
        if validate2(text: sender.text!){
            count += 1
        }
        print(count)

    }
    @IBAction func pwChanged(_ sender: UITextField) {
        if validate3(text: sender.text!){
            count += 1
        }
        print(count)
    }
    @IBAction func pwCheck(_ sender: UITextField) {
        if count == 3 && pwText.text == pwCheck.text {
            registerButton.setImage(registerOk, for: UIControlState.normal)
            registerButton.isEnabled = true
        }
    }
    
    
    @IBAction func registerBut(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation") as? NavigationViewController {
            
            self.present(vc, animated: true, completion: nil)   // 식별자 가르키는 곳으로 이동
        }
    }
    func naviBar() { //네비게이션 투명색만들기
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "roundArrowBackIosBlack48Pt1X")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        registerButton.isEnabled = false
        naviBar()
        idText.layer.addBorder([.bottom], color: .gray, width: 1.0)
                nameText.layer.addBorder([.bottom], color: .gray, width: 1.0)
                pwCheck.layer.addBorder([.bottom], color: .gray, width: 1.0)
                pwText.layer.addBorder([.bottom], color: .gray, width: 1.0)
        super.viewDidLoad()

    }
}
