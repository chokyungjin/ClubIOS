//
//  RecruitCollectionVC.swift
//  club_INU
//
//  Created by 조경진 on 08/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class RecruitCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Smallregister.dummyRegisterList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell
        
        let target = Smallregister.dummyRegisterList[indexPath.row]
        cell.label.text = target.name
        cell.label2.text = "마감날짜 :" + target.insertDate
        cell.backgroundColor = .white
        cell.layer.addBorder([.bottom], color: .black, width: 1.0)
        return cell
    }
}

