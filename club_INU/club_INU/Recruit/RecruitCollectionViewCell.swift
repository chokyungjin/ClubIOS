//
//  RecruitCollectionViewCell.swift
//  club_INU
//
//  Created by 조경진 on 01/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

protocol ClickCellDelegate : class{
    func clickCell(name: String)
}


class RecruitCollectionViewCell: UICollectionViewCell{
    
    
    func getSingle() -> String {
        let date = Date()
        let calendar = Calendar.current //켈린더 객체 생성
        let year = calendar.component(.year, from: date)    //년
        let month = calendar.component(.month, from: date)  //월
        let day = calendar.component(.day, from: date)      //일
        let pdate = "\(year)-\(month)-\(day)"
        return pdate
    }
    
    
    
    public var testCollectionViewDelegate: UICollectionViewDelegate? 
   
    let sport: UIImage = UIImage(named: "label3")!
    let religion: UIImage = UIImage(named: "label1")!
    let culture: UIImage = UIImage(named: "label2")!
    let bongsa: UIImage = UIImage(named: "label6")!
    let hobby: UIImage = UIImage(named: "label5")!
    let study: UIImage = UIImage(named: "label4")!
    var pageCollectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let pageCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        pageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return pageCollectionView
    }()
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.register(UINib(nibName: PageCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: PageCell.reusableIdentifier)
        self.addSubview(pageCollectionView)
        
        pageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 10).isActive = true
        pageCollectionView.backgroundColor = .white
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPageCollectionView()
        pageCollectionView.reloadData()
        self.backgroundColor = .white
        
    }
    
}



extension RecruitCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell

    let target = Smallregister.dummyRegisterList[indexPath.row]
        

        cell.label.text = target.name
        cell.label2.text = "마감날짜 :" + target.insertDate
        cell.peopleLabel.setTitle((UserDefaults.standard.string(forKey: "cruitCount")! + "/" + String(describing: Int(target.count))) , for: .normal)
        switch target.category {
        case "스포츠" :
            cell.button.setImage(sport, for: UIControlState.normal)
            
        case "종교" :
            cell.button.setImage(religion, for: UIControlState.normal)
            
        case "문화" :
            cell.button.setImage(culture, for: UIControlState.normal)
            
        case "봉사" :
            cell.button.setImage(bongsa, for: UIControlState.normal)
            
        case "취미/전시" :
            cell.button.setImage(hobby, for: UIControlState.normal)
            
        case "학술/교양" :
            cell.button.setImage(study, for: UIControlState.normal)
        default: break
        }
        cell.backgroundColor = .white
        cell.layer.addBorder([.bottom], color: .gray, width: 1.0)
        return cell
    }


    //RecruitCollectionViewcell.swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let testDelegate = self.testCollectionViewDelegate else {
            print("리턴")
            return;
        }
        testDelegate.collectionView?(collectionView, didSelectItemAt: indexPath)
 
        print(333)
//        let target = Smallregister.dummyRegisterList[indexPath.row]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "RecruitDetail") as! RecruitDetailViewController
//        vc.cruit = target
//        CellModel.CellTemp.setLogin(data: vc.cruit!)
//        print(CellModel.CellTemp.getCellData())

      //  self.show(vc, sender: Any?.self)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Smallregister.dummyRegisterList.count)
        return Smallregister.dummyRegisterList.count
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension RecruitCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: 50)
        //pageCollectionView.frame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -2.6
    }
}


