//
//  RecruitVC.swift
//  club_INU
//
//  Created by 조경진 on 08/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class RecruitVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
}

extension RecruitVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell
        print(indexPath)
        return cell
    }
    
    //RecruitViewController.swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecruitDetail") as! RecruitDetailViewController
        vc.cruit = CellModel.CellTemp.getCellData()
        self.navigationController?.pushViewController(vc, animated: true)
        //셀 선택시 44가 찍히지 않습니다!
        print(44)
        
        //  self.show(vc, sender: Any?.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Smallregister.dummyRegisterList.count
    }
    
}

extension RecruitVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        print(view.frame.height)
        return CGSize(width: bounds.width, height: view.frame.height)
        //pageCollectionView.frame.height
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
