
import Foundation
import Alamofire    //ios 네트워킹 라이브러리

class NetworkManager {
    
    private let SERVER_URL = "Private"    //club 서버주소
    private let MAIN_URL = "Private"       //main 주소
    private let EVENT_URL = "Private"    //event 주소
    private let USER_URL = "Private"      //사용자 주소
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate     //appDelegate를 다운캐스팅
    
    // singleton
    static let shared = NetworkManager()
    private init() { }
    
    func signIn(id: String, passwd: String, completionHandler: @escaping (String?) -> ()) {
        guard let url = URL.init(string: "Private") else {
                return
            }
        let header = [Private]
        let params = [
            "passwd": passwd ,
            "id": id
        ]
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(res)
                print("성공 입니다")
                print(item)
                completionHandler(item)
                self.appDelegate.delegateClubnum = item     //델리게이트 Clubname에 item 위임
            case .failure(let error):   //실패시
                print(res)
                print("로그인 실패입니다")
                print(error)        //에러 출력

                completionHandler(nil)      //nil 값 넣어줌
            }
        }
    }
    //매개변수 동아리회장, 핸드폰, 구글폼 , 내용
    func updateClub(representative: String, phone: String, application: String, contents: String, completionHandler: @escaping (String?) -> ()) {
        let header = [Private]     //content type 헤더 설정
        let params = [
            "representative": representative,   //대표
            "phone": phone,     //핸드폰 번호
            "application": application, //구글폼
            "contents":contents         //내용
        ]
        //서버 url info, 포스트방식 responseString 으로 응답
        Alamofire.request("\(SERVER_URL)info/\(self.appDelegate.delegateClubnum)", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {     //res의 결과가
            case .success(let item):        //handle success하다면 item 출력후 completionHandler에 넣어줌
                print(item)
                completionHandler(item)
            case .failure(let error):   //실패하면 nil 넣어줌
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    //매개변수 행사이름, 날짜, 시간, 장소
    func eventMake(eventname: String, date: String, time: String, location: String, completionHandler: @escaping (String?) -> ()) {
        let header = [Private]     //content type 헤더 설정
        let params = [
            "eventname": eventname, //행사이름
            "date": date,       //날짜
            "time": time,       //시간
            "location":location //장소
        ]
        //event_url의 new, post방식 , responseString 으로 응답
        Alamofire.request("\(EVENT_URL)new", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {     //res결과
            case .success(let item):    //성공이면 completionHandler에넣어줌
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)  //실패면 nil반환
            }
        }
    }
    //매개변수 행사이름 , 날짜, 시간, 장소
    func eventUpdate(eventname: String, date: String, time: String, location: String, completionHandler: @escaping (String?) -> ()) {
        let header = [Private]     //content type 헤더 설정
        let params = [
            "eventname": eventname, //행사이름
            "date": date,       //날짜
            "time": time,       //시간
            "location":location //장소
        ]
        //EVENT_URL edit responseString 으로 응답
        Alamofire.request("\(EVENT_URL)\(self.appDelegate.delegateEventnum)/edit", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):    //성공이면 completionHandler에넣어줌
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)      //nil 반환
            }
        }
    }
    //행사 삭제, 삭제만 하므로 따로 매개변수가 필요없다.
    func eventDelete(completionHandler: @escaping (String?) -> ()) {
        let header = [Private]     //content type 헤더 설정
        //evnet url로 delete실행, post방식, responseString으로 응답
        Alamofire.request("\(EVENT_URL)\(self.appDelegate.delegateEventnum)/delete", method: .post, headers: header).responseString { res in
            switch res.result {
            case .success(let item):    //성공이면 completionHandler에넣어줌
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)      //nil 반환
            }
        }
    }
    
    
    
    //contact getter
    func getContacts(completionHandler: @escaping ([Contact]?, String?) -> ()) {
        //responseJSON으로 응답
        Alamofire.request(SERVER_URL).responseJSON { response in
            //            let code = response.response?.statusCode
            //            print(code)
            
            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {       //item이 NSArray로 옵셔널 해제가 안된다면
                    // JSONArray
                    completionHandler(nil, "array parsing error")   //nil 넣고 리턴
                    return
                }
                
                var result:[Contact] = []   //contact배열형태의 빈 배열 선언
                
                for object in array {       //array 범위 만큼
                    let obj = Contact()     //contact형 객체 선언
                    if let object = object as? NSDictionary,    //NSDictionary옵셔널 해제가 가능하다면
                    // JSONObject
                        let num = object["num"] as? Int,    //int로 옵셔널 해제
                        let clubname = object["clubname"] as? String,   //String으로 옵셔널 해제
                        let location = object["location"] as? String,//String으로 옵셔널 해제
                        let category = object["category"] as? String{   //String으로 옵셔널 해제
                        if let image1 = object["image1"] as? String{
                            obj.image1 = image1     //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let image2 = object["image2"] as? String{
                            obj.image2 = image2     //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let image3 = object["image3"] as? String {
                            obj.image3 = image3     //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let image4 = object["image4"] as? String{
                            obj.image4 = image4     //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let representative = object["representative"] as? String{
                            obj.representative = representative     //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let phone = object["phone"] as? String{
                            obj.phone = phone       //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let application = object["application"] as? String{
                            obj.application = application       //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        if let contents = object["contents"] as? String{
                             obj.contents = contents        //String으로 옵셔널 해제된다면 obj에 넣어줌
                        }
                        obj.num = num       //obj객체에 넣어줌
                        obj.clubname = clubname      //obj객체에 넣어줌
                        obj.location = location      //obj객체에 넣어줌
                        obj.category = category      //obj객체에 넣어줌
                }
                    result.append(obj)      //객체를 result배열에 추가
                }
                //completionHandler에 result넣어줌
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")      //실패시 nil반환
            }
        }
    }
    
    //mainImg getter
    func getContactsMainImg(completionHandler: @escaping ([mainImg]?, String?) -> ()) {
        //responseJSON으로 응답
        Alamofire.request(MAIN_URL).responseJSON { response in
            //            let code = response.response?.statusCode
            //            print(code)
            
            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {       //item이 NSArray로 옵셔널 해제가 안된다면
                    // JSONArray
                    completionHandler(nil, "array parsing error")   //nil 넣고 리턴
                    return
                }
                
                var result:[mainImg] = []   //mainImg배열 선언
                
                for object in array {
                    let obj = mainImg() //객체생성
                    if let object = object as? NSDictionary,    //NSDictionary타입으로 옵셔널 해제
                        // JSONObject
                        let img = object["img"] as? String{ //img를 String으로 옵셔널 해제 된다면
                        obj.img = img   //객체에 넣어줌
                    }
                    result.append(obj)  //객체를 result에 넣어줌
                }
                
                completionHandler(result, nil)  //completionhandler에 result넣어줌
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")      //실패시 nil반환
            }
        }
    }
    //contact로 evnetlist 받는 getter
    func getContactsEventList(completionHandler: @escaping ([eventList]?, String?) -> ()) {
        //responseJSON로 응답
        Alamofire.request("\(EVENT_URL)list").responseJSON { response in

            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {       //item이 NSArray로 옵셔널 해제가 안된다면
                    // JSONArray
                    completionHandler(nil, "array parsing error")   //nil 넣고 리턴
                    return
                }
                
                var result:[eventList] = [] //evnetlist배열 선언
                
                for object in array {
                    let obj = eventList()       //객체생성
                    if let object = object as? NSDictionary,    //NSDictionary타입으로 옵셔널 해제
                        // JSONObject
                        let eventnum = object["eventnum"] as? Int,  //int 형으로 옵셔널 해제
                        let clubname = object["clubname"] as? String,   //String형으로 옵셔널 해제
                        let eventname = object["eventname"] as? String,//String형으로 옵셔널 해제
                        let time = object["time"] as? String,   //String형으로 옵셔널 해제
                        let location = object["location"] as? String{   //String형으로 옵셔널 해제
                        if let date = object["date"] as? String{    //String형으로 옵셔널 해제 가능하다면,
                        let format = DateFormatter()    //format객체 생성
                        format.dateFormat = "yyyy-MM-dd"    //포맷 지정
                            //2018-08-23 15:00
                            //"yyyy-MM-dd HH:mm"
                        obj.date = format.date(from: date)  //obj.date에 foramt.data 대입
                        }
                        obj.eventnum = eventnum     //obj에 대입
                        obj.clubname = clubname     //obj에 대입
                        obj.eventname = eventname       //obj에 대입
                        obj.time = time     //obj에 대입
                        obj.location = location     //obj에 대입
                    }
                    result.append(obj)      //obj를 result에 추가
                }
                //result를 completionHandler에 넣어줌
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")  //실패시 nil반환
            }
        }
    }
    
    //이미지 삭제, 숫자 파라미터
    func deleteImage(num: String, completionHandler: @escaping (String?) -> ()){
        let header = [Private]     //content type 헤더 설정
        print("\(SERVER_URL)image/\(self.appDelegate.delegateClubnum)/\(num)")
        //responseStrring으로 응답  server_url의 image
        Alamofire.request("\(SERVER_URL)image/\(self.appDelegate.delegateClubnum)/\(num)", method: .delete, parameters: nil, headers: header).responseString { res in
            switch res.result {
            case .success(let item):    //성공시 completionHandler에 넣어줌
                print(item)
                
                completionHandler(item)
            case .failure(let error):
                print(error)
                
                completionHandler(nil)  //실패시 nil 넣어줌
            }
        }
    }
}


