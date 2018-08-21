//
//  ListViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 26..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var realm: Realm!
    var arrayData: Results<Contact>!
    var click = String()
    var searchButton = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController?.searchBar.delegate = self
        
        realm = try! Realm()
        if click == "" {
            arrayData = realm.objects(Contact.self).filter("clubname CONTAINS %@ || category CONTAINS %@", searchButton,searchButton).sorted(byKeyPath: "num")
            self.navigationItem.title = "\(searchButton) 검색결과"
        }else {
               arrayData = realm.objects(Contact.self).filter("category == %@", click).sorted(byKeyPath: "num")
            self.navigationItem.title = click
        }
        
        
        naviBar()
        tableView.reloadData()

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
        

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 378
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        cell.ClubName.text = arrayData[indexPath.row].clubname
        cell.ClubLocation.text = arrayData[indexPath.row].location

        cell.ClubImage.layer.masksToBounds = true
        cell.ClubImage.layer.cornerRadius = 2.0
        cell.ClubImage.layer.masksToBounds = false
        cell.ClubImage.layer.borderWidth = 1.0
        cell.ClubImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        
        
        if arrayData[indexPath.row].image1 != nil{
//            http://appcenter.us.to:3303/\(image1!)
//            let logo = "http://appcenter.us.to:3303/club/image/\(arrayData[indexPath.row].image1!)"
            let logo = "http://appcenter.us.to:3303/\(arrayData[indexPath.row].image1!)"
            print(logo,"logo")
            let loogo = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            cell.ClubImage.kf.setImage(with: loogo)
        } else {
            cell.ClubImage.image = #imageLiteral(resourceName: "A")
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController{
            vc.getName = arrayData[indexPath.row].clubname
            self.navigationController?.show(vc, sender: nil)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    
    
    func naviBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.searchController?.searchBar.text
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let searchClub = navigationItem.searchController?.searchBar.text
//    }
}
