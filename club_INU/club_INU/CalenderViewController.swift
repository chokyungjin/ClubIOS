//
//  CallenderViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 11..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class CalenderViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var calTable: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    
//    var realm: Realm!
//    var arrayData: Results<eventList>?
    var arrayData: [eventList]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calTable.delegate = self
        calTable.dataSource = self
        
        calTable.tableFooterView = UIView()
        
//        calTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setupafter loading the view.
        
//        realm = try! Realm()
//        arrayData = realm.objects(eventList.self).sorted(byKeyPath: "eventnum")
        

        calendar.clipsToBounds = true

        self.calendar.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
        
        arrayData = DBManager.shared.getEventList(date: Date())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = arrayData?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CalendarTableViewCell
//        let dateFormat = DateFormatter()
//        let datecal = dateFormat.string(from: arrayData[indexPath.row].date!)
//        print(datecal)
//        cell.dayLabel.text = dateFormat.string(from: arrayData[indexPath.row].date!)
        
        if let array = arrayData {
            
            let item = array[indexPath.row]
            cell.eventNameLabel.text = item.eventname
            cell.timeLabel.text = "시간: " + item.time
            cell.locationLabel.text = "장소: " + item.location
            cell.dayLabel.text = item.clubname
        }
        
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        return cell
        
    }
}

extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        self.arrayData = DBManager.shared.getEventList(date: date)
//        print(arrayData)
        DispatchQueue.main.async {
            self.calTable.reloadData()
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if DBManager.shared.getEventCount(for: date) == 0 {
            return 0
        }
        return 1
    }
}

