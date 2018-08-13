
import Foundation
import RealmSwift

class DBManager {
    
    static let shared = DBManager()
    
    private init() { }
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print("Could not access Realm")
            return nil
        }
    }
    
    func saveContact(num : Int, clubname : String, location : String, category : String,
                              image1 : String? = nil, image2 : String? = nil, image3 : String? = nil, image4 : String? = nil,
                 representative : String? = nil, phone : String? = nil, application : String? = nil, contents : String? = nil) {
        
        let obj = Contact()
        obj.num = num
        obj.clubname = clubname
        obj.location = location
        obj.category = category
        obj.image1 = image1
        obj.image2 = image2
        obj.image3 = image3
        obj.image4 = image4
        obj.representative = representative
        obj.phone = phone
        obj.application = application
        obj.contents = contents
        
        try! realm?.write {
            realm?.add([obj])
        }
    }
    
    func saveContact(array:[Contact]) {
        try! realm?.write {
            realm?.add(array)
        }
    }
    func getContact() -> [Contact] {
        if let objects = realm?.objects(Contact.self) {
            return Array(objects)
        }
        return []
    }
    
    func getCategory(category: String) -> [Contact] {
        if let Category = realm?.objects(Contact.self).filter("category == %@", category).sorted(byKeyPath: "num") {
            return Array(Category)
        }
        
        return []
    }
    
    func getClubinfo(num: Int) -> [Contact] {
        if let Category = realm?.objects(Contact.self).filter("num == %@", num) {
            return Array(Category)
        }
        return[]
    }
    
    func deleteAll(){
        try! realm?.write {
            realm?.deleteAll()
        }
    }
          // mainImg
    func saveMainImg(img : String){
        let obje = mainImg()
        obje.img = img
        
        try! realm?.write {
            realm?.add(obje)
        }
    }
    
    func saveMainImg(array:[mainImg]) {
        try! realm?.write {
            realm?.add(array)
        }
    }

    func getMainImg() -> [mainImg] {
        if let mainImg = realm?.objects(mainImg.self) {
            return Array(mainImg)
        }
        return []
    }
    
        //eventlist
    func saveEventList(eventnum : Int, clubname : String , eventname : String, date : Date, time : String, location : String){
        let object = eventList()
        object.eventnum = eventnum
        object.clubname = clubname
        object.eventname = eventname
        object.date = date
        object.time = time
        object.location = location
        
        try! realm?.write {
            realm?.add(object)
        }
    }
    func saveEventList(array:[eventList]) {
        try! realm?.write {
            realm?.add(array)
        }
    }
    
    func getEventList(clubName: String) -> [eventList]{
        if let eventList = realm?.objects(eventList.self).filter("clubname == %@",clubName) {
            return Array(eventList)
        }
        return []
    }
    
    func getEventDetail(eventNum: Int) -> [eventList]{
        if let eventList = realm?.objects(eventList.self).filter("eventnum == %@",eventNum) {
            return Array(eventList)
        }
        return []
    }
    
    func getEventList(date: Date) -> [eventList] {
        if let result = realm?.objects(eventList.self).filter("date == %@", date) {
            return Array(result)
        }
        return []
    }
    
    func getEventCount(for date: Date) -> Int {
        if let count = realm?.objects(eventList.self).filter("date == %@", date).count {
            return count
        }
        return 0
    }
}

