
import Foundation
import RealmSwift

class DBManager {
    
    static let shared = DBManager() //DB매니저 기본 객체를 전역상수로 설정
    
    private init() { }  //초기화 메소드
    
    var realm: Realm? { //realm이 Realm타입이라면
        do {
            return try Realm()  //Realm반환, 모델 만들어줌
        } catch {
            print("Could not access Realm") //아니면 nil반환
            return nil
        }
    }
    //Realm에 insert 해주는 함수
    func saveContact(num : Int, clubname : String, location : String, category : String,
                     image1 : String? = nil, image2 : String? = nil, image3 : String? = nil, image4 : String? = nil,
                     representative : String? = nil, phone : String? = nil, application : String? = nil, contents : String? = nil) {
        
        let obj = Contact()     //Contact 객체 생성
        obj.num = num       //생성된 객체에 num 대입
        obj.clubname = clubname     //대입
        obj.location = location     //대입
        obj.category = category     //대입
        obj.image1 = image1     //대입
        obj.image2 = image2     //대입
        obj.image3 = image3     //대입
        obj.image4 = image4     //대입
        obj.representative = representative //대입
        obj.phone = phone       //대입
        obj.application = application       //대입
        obj.contents = contents     //대입
        
        try! realm?.write { //realm 객체에 쓰기 트랜잭션 수행
            realm?.add([obj])   //obj를 realm에 추가
        }
    }
    //매개변수지정 없이 배열로 바로 insert 해주는 함수
    func saveContact(array:[Contact]) {     //Contact 객체배열 array 를 realm에 추가
        try! realm?.write {
            realm?.add(array)
        }
    }
    //Realm에서 Contact를 getter해주는 함수
    func getContact() -> [Contact] {    //리턴값은 Contact
        if let objects = realm?.objects(Contact.self) {     //realm옵셔널 값 해제 하면서 return Array
            return Array(objects)
        }
        return []   //바인딩 해제 안되면 빈 [] 리턴
    }
    
    func getCategory(category: String) -> [Contact] {   //매개변수 카테고리 category
        if let Category = realm?.objects(Contact.self).filter("category == %@", category).sorted(byKeyPath: "num") {        //filter 해서 category 로 필터링, num으로 정렬.
            return Array(Category)  //array값 리턴
        }
        
        return []   //옵셔널 바인딩 해제 안되면 빈 [] 리턴
    }
    
    func getClubinfo(num: Int) -> [Contact] {   //filter해서 num으로 필터링
        if let Category = realm?.objects(Contact.self).filter("num == %@", num) {
            return Array(Category)  //array값 리턴
        }
        return[]
    }
    
    func deleteAll(){
        try! realm?.write {         //commit
            realm?.deleteAll()      //realm 전부 삭제
        }
    }
    // mainImg
    func saveMainImg(img : String){
        let obje = mainImg()    //메인 이미지 객체 생성
        obje.img = img  //매개변수의 이미지 대입
        
        try! realm?.write {     //commit
            realm?.add(obje)    //이미지 추가
        }
    }
    
    func saveMainImg(array:[mainImg]) { //매인 이미지 배열 파라미터
        try! realm?.write {     //commit
            realm?.add(array)   //배열 추가
        }
    }
    
    func getMainImg() -> [mainImg] {    //리턴값 mainImg
        if let mainImg = realm?.objects(mainImg.self) { //메인 이미지 옵셔널 바인딩 해제 가능하면
            return Array(mainImg)   //리턴 배열
        }
        return []   //빈 배열 리턴
    }
    
    //eventlist
    func saveEventList(eventnum : Int, clubname : String , eventname : String, date : Date, time : String, location : String){
        let object = eventList()    //행사등록 객체 생성
        object.eventnum = eventnum  //이벤트 번호
        object.clubname = clubname  //동아리 이름
        object.eventname = eventname    //이벤트 이름
        object.date = date  //날짜
        object.time = time  //시간
        object.location = location      //장소
        
        try! realm?.write {
            realm?.add(object)  //쓰기
        }
    }
    func saveEventList(array:[eventList]) {
        try! realm?.write {
            realm?.add(array)   //이벤트 쓰기
        }
    }
    
    func getTempEventList() -> [eventList]{
        if let eventList = realm?.objects(eventList.self) {
            return Array(eventList)     //동아리 이름으로 필터링 배열 리턴
        }
        return []
    }
    
    func getEventList(clubName: String) -> [eventList]{
        if let eventList = realm?.objects(eventList.self).filter("clubname == %@",clubName) {
            return Array(eventList)     //동아리 이름으로 필터링 배열 리턴
        }
        return []
    }
    
    func getEventDetail(eventNum: Int) -> [eventList]{
        if let eventList = realm?.objects(eventList.self).filter("eventnum == %@",eventNum) {
            return Array(eventList)     //이벤트 번호 필터링 배열 리턴
        }
        return []
    }
    
    func getEventList(date: Date) -> [eventList] {
        if let result = realm?.objects(eventList.self).filter("date == %@", date) {
            return Array(result)        //날짜 필터링 배열 리턴
        }
        return []
    }
    
    func getEventCount(for date: Date) -> Int {
        if let count = realm?.objects(eventList.self).filter("date == %@", date).count {
            return count    //날짜 필터링 갯수 리턴
        }
        return 0
    }
    //    //@objc dynamic var division : String?
    //    @objc dynamic var smallrepresentative : String?
    //    @objc dynamic var address: String?
    //    @objc dynamic var deadline: String?
    //    @objc dynamic var count : String?
    //    @objc dynamic var smallContent: String?
    func saveSmallGroup(groupnum: Int,smallrepresentative : String , address: String, deadline: String, count : Float,smallContent: String, division: String){
        let object = smallGroup()    //행사등록 객체 생성
        object.groupnum = groupnum
        object.smallrepresentative = smallrepresentative  //이벤트 번호
        object.address = address  //동아리 이름
        object.deadline = deadline    //이벤트 이름
        object.count = count  //날짜
        object.smallContent = smallContent  //시간
        object.division = division
        
        try! realm?.write {
            realm?.add(object)  //쓰기
        }
    }
    func saveSmallGroup(array:[smallGroup]) {
        try! realm?.write {
            realm?.add(array)   //이벤트 쓰기
        }
    }
    
    func getSmallGroup(division: String) -> [smallGroup]{
        if let smallGroup = realm?.objects(smallGroup.self).filter("division == %@",division) {
            return Array(smallGroup)     //동아리 이름으로 필터링 배열 리턴
        }
        return []
    }
    func getGroupDetail(groupnum: Int) -> [smallGroup]{
        if let smallGroup = realm?.objects(smallGroup.self).filter("groupnum == %@",groupnum) {
            return Array(smallGroup)     //이벤트 번호 필터링 배열 리턴
        }
        return []
    }
    
    func getSmallGroup(deadline: String) -> [smallGroup] {
        if let result = realm?.objects(smallGroup.self).filter("deadline == %@", deadline) {
            return Array(result)        //날짜 필터링 배열 리턴
        }
        return []
    }
    
    func getGroupCount(for groupnum: Int) -> Int {
        if let count = realm?.objects(smallGroup.self).filter("groupnum == %@", groupnum).count {
            return count    //날짜 필터링 갯수 리턴
        }
        return 0
    }
}



