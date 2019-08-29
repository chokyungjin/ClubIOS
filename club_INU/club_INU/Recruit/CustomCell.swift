//
//  CustomCell.swift
//  CustomTabBar
//
//  Created by 이동건 on 2018. 4. 18..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var label1: UILabel = {
        let label1 = UILabel()
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label1.textColor = .black
        label1.translatesAutoresizingMaskIntoConstraints = false
        return label1
    }()
 
    var label2: UILabel = {
        let label2 = UILabel()
        label2.textColor = .black
        // label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label2.translatesAutoresizingMaskIntoConstraints = false
        return label2
    }()
    override var isSelected: Bool {
        didSet{
            print("Changed")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label1)
        self.addSubview(label2)
        label1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label1.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
