
//
//  DetailTableView.swift
//  club_INU
//
//  Created by 조경진 on 06/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
import Toast_Swift
import LinearProgressView

class DetailTableView: UITableViewCell  {
    
public var testTableViewDelegate: UITableViewDelegate?
    
    var MaxCount : Float = 10.0
    var currentCount : Float = (UserDefaults.standard.float(forKey: "cruitCount"))
    var tmpCount : Int = 0
    var tmpCount2 : Int = 0

    
    @IBOutlet var categoryText: UILabel!
    @IBOutlet var contentText: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var category: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var linkClickBut: UIButton!
    @IBOutlet weak var blue: UILabel!
    @IBOutlet weak var pink: UILabel!
    
    
    
    @IBAction func createBut(_ sender: Any) {
    
        progressBar.setProgress((UserDefaults.standard.float(forKey: "cruitCount")), animated: false)
        perform(#selector(updateProgress), with: nil)
        if (currentCount != MaxCount){
            self.viewController()?.view.makeToast("찬성하셨습니다!")
        }
    }
    
    
    @objc func updateProgress(){
        
        currentCount = currentCount + 1
         UserDefaults.standard.set(currentCount, forKey: "cruitCount")
        blue.text = String(describing: Int(UserDefaults.standard.float(forKey: "cruitCount")))
        progressBar.progress = Float((UserDefaults.standard.float(forKey: "cruitCount")) / MaxCount)
        
        if currentCount == MaxCount {
            self.viewController()?.view.makeToast("인원이 채워졌습니다!")
        linkClickBut.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        linkClickBut.layer.cornerRadius = 10
        createButton.layer.cornerRadius = 10
        MaxCount = CellModel.CellTemp.getCellData().count
        tmpCount = Int(UserDefaults.standard.integer(forKey: "cruitCount"))
        tmpCount2 = Int(MaxCount)
        blue.text = String(tmpCount)
        pink.text = String(tmpCount2)
      
        progressBar.setProgress(Float((UserDefaults.standard.float(forKey: "cruitCount")) / MaxCount), animated: false)

        pink.textColor = UIColor(red: 255.0 / 255.0, green: 162.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
        blue.textColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    
}



