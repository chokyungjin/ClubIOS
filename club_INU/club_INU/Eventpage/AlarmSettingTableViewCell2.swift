//
//  AlarmSettingTableViewCell.swift
//  club_INU
//
//  Created by 조경진 on 22/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

class AlarmSettingTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var label1: UILabel!


    @IBAction func voteDeadline(_ sender: Any) {
        UserDefaults.standard.set(switch1.isOn, forKey: "switchState")
    }

    
    override func awakeFromNib() {
        switch1.isOn = UserDefaults.standard.bool(forKey: "switchState")
       
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
