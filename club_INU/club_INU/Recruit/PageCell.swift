//
//  PageCell.swift
//  CustomTabBar
//
//  Created by 이동건 on 2018. 4. 20..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
   
    var DetailLabel: UIButton = {
        let DetailLabel = UIButton()
        let tmp: UIImage = UIImage(named: "d")!
        
        
        DetailLabel.setImage(tmp, for: .normal)
        DetailLabel.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        DetailLabel.setTitle(" - 7", for: .normal)
        DetailLabel.setTitleColor(UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0), for: .normal)
        DetailLabel.translatesAutoresizingMaskIntoConstraints = false
        DetailLabel.titleEdgeInsets.bottom = 4
        DetailLabel.imageEdgeInsets.bottom = 2

        return DetailLabel
    }()
    
    var peopleLabel: UIButton = {
        let peopleLabel = UIButton()
        let tmp: UIImage = UIImage(named: "인원-2")!
        peopleLabel.setImage(tmp, for: .normal)
        peopleLabel.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        
        peopleLabel.setTitleColor(.gray, for: .normal)
        peopleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return peopleLabel
    }()
    
    var responseLabel: UIButton = {
        
        let responseLabel = UIButton()
        let tmp: UIImage = UIImage(named: "1203")!
        responseLabel.setImage(tmp, for: .normal)
        responseLabel.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        responseLabel.setTitle(" 8", for: .normal)
        responseLabel.setTitleColor(.gray, for: .normal)
        responseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return responseLabel
        
    }()

  
    var button: UIButton = {
        let registerOk: UIImage = UIImage(named: "label2")!
        let button = UIButton()
  
        button.setImage(registerOk, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "1"
        //  label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var label2: UILabel = {
        let label2 = UILabel()
        label2.textColor = .gray
        label2.text = "2"
        // label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label2.translatesAutoresizingMaskIntoConstraints = false
        return label2
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        self.addSubview(label2)
        self.addSubview(button)
        self.addSubview(DetailLabel)
        self.addSubview(peopleLabel)
        self.addSubview(responseLabel)
        
        
        self.backgroundColor = .white
        
        button.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: self.leadingAnchor , constant: 60).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        label.layer.addBorder([.bottom], color: .gray, width: 1.0)
        label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        label2.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 5).isActive = true
        label2.trailingAnchor.constraint(equalTo: responseLabel.leadingAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 5).isActive = true
        
        
        responseLabel.leadingAnchor.constraint(equalTo: label2.trailingAnchor, constant: 0).isActive = true
        responseLabel.trailingAnchor.constraint(equalTo: DetailLabel.leadingAnchor, constant: -10).isActive = true
        responseLabel.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 0).isActive = true
        
        
        DetailLabel.leadingAnchor.constraint(equalTo: responseLabel.trailingAnchor, constant: 0).isActive = true
        DetailLabel.trailingAnchor.constraint(equalTo: peopleLabel.leadingAnchor, constant: -10).isActive = true
        DetailLabel.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 0).isActive = true
        
        peopleLabel.leadingAnchor.constraint(equalTo: DetailLabel.trailingAnchor, constant: 0).isActive = true
      
        peopleLabel.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 0).isActive = true
        
        
        
        
        
    }
}



