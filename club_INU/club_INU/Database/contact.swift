//
//  contact.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 16..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import Foundation   //원시데이터(String, int, double), 컬렉션, 운영체제 서비스를 사용해 App의 기능을 관리하는 프레임워크
import RealmSwift   //Pod의 RealmSwift 프레임워크 임포트 -> DB 연동하기 위해
//Realm에 들어갈 클래스(테이블)들을 설정하는 클래스

class Contact : Object {    //pod 의 Realm 상속
    
    @objc dynamic var num : Int = 0     //db에 접근할수있게  @objc dynamic로 설정해줘야함 num은 순서부여 숫자
    @objc dynamic var clubname : String = ""    //clubname
    @objc dynamic var location : String = ""    //location
    @objc dynamic var category : String = ""    //category
    @objc dynamic var image1 : String?      //image1
    @objc dynamic var image2 : String?      //image2
    @objc dynamic var image3 : String?      //image3
    @objc dynamic var image4 : String?      //image4
    @objc dynamic var representative : String?  //회장이름
    @objc dynamic var phone : String?       //회장 전화번호
    @objc dynamic var application : String?     //구글폼 연결
    @objc dynamic var contents : String?    //내용
}

class mainImg : Object {    //메인 이미지 클래스
    @objc dynamic var img : String = "" //메인 이미지 받을 변수 선언.
}

class eventList : Object {  //행사 등록 클래스
    @objc dynamic var eventnum : Int = 0        //이벤트 번호
    @objc dynamic var clubname : String = ""    //동아리 이름
    @objc dynamic var eventname : String = ""   //행사 이름
    @objc dynamic var date : Date? = nil    //날짜
    @objc dynamic var time : String = ""    //시간
    @objc dynamic var location : String = ""    //장소
}

class smallGroup: Object {
    @objc dynamic var groupnum : Int = 0        //이벤트 번호
    @objc dynamic var division : String = ""    //소모임 카테고리
    @objc dynamic var smallrepresentative : String = "" //소모임 회장이름
    @objc dynamic var address: String = ""      //오픈채팅 주소
    @objc dynamic var deadline: String = ""     //마감날짜
    @objc dynamic var count : Float = 0         //충족인원
    @objc dynamic var smallContent: String = ""   //내용
    
}


