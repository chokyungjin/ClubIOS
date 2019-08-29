//
//  Cruit.swift
//  club_INU
//
//  Created by 조경진 on 05/07/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import Foundation

class Smallregister {
    var content: String
    var name: String
    var category: String
    var link : String
    var insertDate : String
    var count : Float
    
    init(category : String){
        self.category = category
        content = String()
        name = String()
        link = String()
        insertDate = String()
        count = Float()
    }
    init(category : String, content : String , name : String, link : String){
        self.category = category
        self.content = content
        self.name = name
        self.link = link
       insertDate = String()
        count = Float()
    }
    init(category : String, content : String , name : String, link : String, insertDate: String, count: Float){
        self.category = category
        self.content = content
        self.name = name
        self.link = link
        self.insertDate = insertDate
        self.count = count
    }
    
    func getName(name: String) -> String{
        return name
    }
    
    static var dummyRegisterList = [
        Smallregister(category: "스포츠",content : "알찬 축구" , name : "축구하실분!", link : "www.naver.com",insertDate: "2019-07-07",count: 15.0),
        Smallregister(category: "교양/학술",content : "알찬 토익" , name : "농구하실분!", link : "www.google.com",insertDate: "2018-12-31",count: 15.0)
        ]
}
