
import Foundation
import Alamofire

class NetworkManager {
    
    private let SERVER_URL = "http://appcenter.us.to:3303/club/"
    private let MAIN_URL = "http://appcenter.us.to:3303/main"
    private let EVENT_URL = "http://appcenter.us.to:3303/event/"
    private let USER_URL = "http://appcenter.us.to:3303/user/"

    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // singleton
    static let shared = NetworkManager()
    private init() { }
    
    func login(id: String, pw: String, completionHandler: @escaping (String?) -> ()) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [
            "id": id,
            "pw": pw
        ]
        
        Alamofire.request("\(USER_URL)login", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                completionHandler(item)
                self.appDelegate.delegateClubnum = item
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    func updateClub(representative: String, phone: String, application: String, contents: String, completionHandler: @escaping (String?) -> ()) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [
            "representative": representative,
            "phone": phone,
            "application": application,
            "contents":contents
        ]
        
        Alamofire.request("\(SERVER_URL)info/\(self.appDelegate.delegateClubnum)", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    
    func eventMake(eventname: String, date: String, time: String, location: String, completionHandler: @escaping (String?) -> ()) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [
            "eventname": eventname,
            "date": date,
            "time": time,
            "location":location
        ]
        
        Alamofire.request("\(EVENT_URL)new", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    func eventUpdate(eventname: String, date: String, time: String, location: String, completionHandler: @escaping (String?) -> ()) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [
            "eventname": eventname,
            "date": date,
            "time": time,
            "location":location
        ]
        
        Alamofire.request("\(EVENT_URL)\(self.appDelegate.delegateEventnum)/edit", method: .post, parameters: params, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    func eventDelete(completionHandler: @escaping (String?) -> ()) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request("\(EVENT_URL)\(self.appDelegate.delegateEventnum)/delete", method: .post, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                completionHandler(item)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    
    
    
    func getContacts(completionHandler: @escaping ([Contact]?, String?) -> ()) {
        
        Alamofire.request(SERVER_URL).responseJSON { response in
            //            let code = response.response?.statusCode
            //            print(code)
            
            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {
                    // JSONArray
                    completionHandler(nil, "array parsing error")
                    return
                }
                
                var result:[Contact] = []
                
                for object in array {
                    let obj = Contact()
                    if let object = object as? NSDictionary,
                    // JSONObject
                        let num = object["num"] as? Int,
                        let clubname = object["clubname"] as? String,
                        let location = object["location"] as? String,
                        let category = object["category"] as? String{
                        if let image1 = object["image1"] as? String{
                            obj.image1 = image1
                        }
                        if let image2 = object["image2"] as? String{
                            obj.image2 = image2
                        }
                        if let image3 = object["image3"] as? String {
                            obj.image3 = image3
                        }
                        if let image4 = object["image4"] as? String{
                            obj.image4 = image4
                        }
                        if let representative = object["representative"] as? String{
                            obj.representative = representative
                        }
                        if let phone = object["phone"] as? String{
                            obj.phone = phone
                        }
                        if let application = object["application"] as? String{
                            obj.application = application
                        }
                        if let contents = object["contents"] as? String{
                             obj.contents = contents
                        }
                        obj.num = num
                        obj.clubname = clubname
                        obj.location = location
                        obj.category = category
                }
                    result.append(obj)
                }
                
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")
            }
        }
    }
    func getContactsMainImg(completionHandler: @escaping ([mainImg]?, String?) -> ()) {
        
        Alamofire.request(MAIN_URL).responseJSON { response in
            //            let code = response.response?.statusCode
            //            print(code)
            
            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {
                    // JSONArray
                    completionHandler(nil, "array parsing error")
                    return
                }
                
                var result:[mainImg] = []
                
                for object in array {
                    let obj = mainImg()
                    if let object = object as? NSDictionary,
                        // JSONObject
                        let img = object["img"] as? String{
                        obj.img = img
                    }
                    result.append(obj)
                }
                
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")
            }
        }
    }
    
    func getContactsEventList(completionHandler: @escaping ([eventList]?, String?) -> ()) {
        
        Alamofire.request("\(EVENT_URL)list").responseJSON { response in

            switch response.result {
            case .success(let item):
                guard let array = item as? NSArray else {
                    // JSONArray
                    completionHandler(nil, "array parsing error")
                    return
                }
                
                var result:[eventList] = []
                
                for object in array {
                    let obj = eventList()
                    if let object = object as? NSDictionary,
                        // JSONObject
                        let eventnum = object["eventnum"] as? Int,
                        let clubname = object["clubname"] as? String,
                        let eventname = object["eventname"] as? String,
                        let time = object["time"] as? String,
                        let location = object["location"] as? String{
                        if let date = object["date"] as? String{
                        let format = DateFormatter()
                        format.dateFormat = "yyyy-MM-dd"
                            //2018-08-23 15:00
                            //"yyyy-MM-dd HH:mm"
                        obj.date = format.date(from: date)
                        }
                        obj.eventnum = eventnum
                        obj.clubname = clubname
                        obj.eventname = eventname
                        obj.time = time
                        obj.location = location
                    }
                    result.append(obj)
                }
                
                completionHandler(result, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "fail")
            }
        }
    }
    
    
    func deleteImage(num: String, completionHandler: @escaping (String?) -> ()){
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        print("\(SERVER_URL)image/\(self.appDelegate.delegateClubnum)/\(num)")
        Alamofire.request("\(SERVER_URL)image/\(self.appDelegate.delegateClubnum)/\(num)", method: .delete, parameters: nil, headers: header).responseString { res in
            switch res.result {
            case .success(let item):
                print(item)
                
                completionHandler(item)
            case .failure(let error):
                print(error)
                
                completionHandler(nil)
            }
        }
    }
}

