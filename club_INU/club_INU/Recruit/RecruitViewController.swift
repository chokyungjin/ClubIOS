//
//  RecruitViewController.swift
//  club_INU
//
//  Created by 조경진 on 15/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import UIKit

class RecruitViewController: UIViewController,CustomMenuBarDelegate {
       
    var pageCollectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var customMenuBar = CustomMenuBar()
    
    func setupCustomTabBar(){
        self.view.addSubview(customMenuBar)
        customMenuBar.delegate = self
        customMenuBar.translatesAutoresizingMaskIntoConstraints = false
        
        customMenuBar.indicatorViewWidthConstraint.constant = self.view.frame.width / 2
        customMenuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        customMenuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        customMenuBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 151.0).isActive = true
        
        //            customMenuBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20.0).isActive = true
        customMenuBar.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.reloadData()
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(UINib(nibName: RecruitCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: RecruitCollectionViewCell.reusableIdentifier)
        self.view.addSubview(pageCollectionView)
        
        pageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.customMenuBar.bottomAnchor, constant: 5).isActive = true
    }
    
    @IBOutlet weak var writeButton: UIButton!
    @IBAction func writeBut(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecruitOkViewController") as! RecruitOkViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        setupCustomTabBar()
        setupPageCollectionView()
        navigationColor()
        pageCollectionView.backgroundColor = .white
        pageCollectionView.reloadData()
    }
    func navigationColor() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupPageCollectionView()
        navigationColor()
        pageCollectionView.backgroundColor = .white
        pageCollectionView.reloadData()
                
        // Do any additional setup after loading the view.
    }
    
}

extension RecruitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecruitCollectionViewCell.reusableIdentifier, for: indexPath) as! RecruitCollectionViewCell
        cell.testCollectionViewDelegate = self

        print(indexPath)
        
        return cell
    }
    
    
    
    //RecruitViewController.swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
        let target = Smallregister.dummyRegisterList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecruitDetail") as! RecruitDetailViewController
        
        vc.cruit = target
        CellModel.CellTemp.setData(data: vc.cruit!)
        
        //self.navigationController?.show(vc, sender: Any?.self)
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension RecruitViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(pageCollectionView.frame.height)
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
        //pageCollectionView.frame.height
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


