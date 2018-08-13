//
//  contact.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 16..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import Foundation
import RealmSwift


class Contact : Object {
    
    @objc dynamic var num : Int = 0
    @objc dynamic var clubname : String = ""
    @objc dynamic var location : String = ""
    @objc dynamic var category : String = ""
    @objc dynamic var image1 : String?
    @objc dynamic var image2 : String?
    @objc dynamic var image3 : String?
    @objc dynamic var image4 : String?
    @objc dynamic var representative : String?
    @objc dynamic var phone : String?
    @objc dynamic var application : String?
    @objc dynamic var contents : String?
}

class mainImg : Object {
    @objc dynamic var img : String = ""
}

class eventList : Object {
    @objc dynamic var eventnum : Int = 0
    @objc dynamic var clubname : String = ""
    @objc dynamic var eventname : String = ""
    @objc dynamic var date : Date? = nil
    @objc dynamic var time : String = ""
    @objc dynamic var location : String = ""
}


