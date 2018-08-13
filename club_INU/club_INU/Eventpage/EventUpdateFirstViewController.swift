//
//  ClubUpdateFirstViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 23..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
//import SwiftyJSON
import Toast_Swift


class EventUpdateFirstViewController: UIViewController, UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource{
    

    
    @IBOutlet weak var eventName: UITextField!
    
    var clubName = String()
    var eventNumber = String()
    let eventnumPicker = UIPickerView()
    var eventList: [eventList] = []
    var pickerRow: [String] = []
    var pickerName: [String] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layerview()
        createGradientLayer()
        clubName = self.appDelegate.delegateClubname
        
//        arrayData = realm.objects(eventList.self).filter("clubname == %@", clubName).sorted(byKeyPath: "num")
        eventList = DBManager.shared.getEventList(clubName: clubName)
        print(eventList.count)
        
        for j in 0..<eventList.count{
            var temp = eventList[j]["eventnum"]
            pickerRow.append("\(temp!)")
            temp = eventList[j]["eventname"]
            pickerName.append("\(temp!)")
            print(pickerRow)
            print(pickerName)
        }
        eventName.inputView = eventnumPicker

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layerview() {
        eventnumPicker.delegate = self
        eventnumPicker.dataSource = self
        eventName.delegate = self
        eventName.layer.borderColor = UIColor.white.cgColor
        eventName.layer.borderWidth=1.0
    }

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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerName.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventName.text = pickerName[row]
        eventNumber = pickerRow[row]
    }
    @IBAction func nextButton(_ sender: Any) {
//        self.appDelegate.delegateEventnum = eventNum.text!
        self.appDelegate.delegateEventnum = eventNumber
        if self.appDelegate.delegateEventnum == "" {
            self.view.makeToast("행사 번호를 입력해 주세요!")
        }else{
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventUpdate") as? EventUpdateViewController{
            self.navigationController?.show(vc, sender: nil)
            }
//            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventUpdate") as! EventUpdateViewController
//            self.addChildViewController(popOverVC)
//            popOverVC.view.frame = self.view.frame
//            self.view.addSubview(popOverVC.view)
//            popOverVC.didMove(toParentViewController: self)
        }
        
    }
    

}
