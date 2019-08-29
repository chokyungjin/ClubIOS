//
//  ClubMake2ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 24..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Alamofire        //ios네트워크 라이브러리
import Kingfisher       //웹에있는 이미지 가져오는 라이브러리

//뷰 컨트롤러, 이미지피커 컨트롤러 델리게이트, 네비게이션 컨드롤러 델리게이트 상속
class ClubImageViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    var gradientLayer: CAGradientLayer! //Gradient를 표현하기위해 선언
    lazy var imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController() //UIImagePickerController객체 생성
        imagePicker.delegate = self     //imagePicker에게 위임
        return imagePicker  //imagePicker리턴
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //옵셔널 해제
    
    var selectedImage: UIImage?     //UIImage형 선언
    
    var clubDetail: [Contact] = []      //Contact형 배열 선언

    
    @IBOutlet weak var imageView1: UIImageView!     //이미지뷰 선언
    @IBOutlet weak var imageView2: UIImageView!     //이미지뷰 선언
    @IBOutlet weak var imageView3: UIImageView!     //이미지뷰 선언
    @IBOutlet weak var imageView4: UIImageView!     //이미지뷰 선언
    
    
    @IBAction func sendButton(_ sender: Any) {      //보내기버튼 메소드
//이미지뷰 이미지가 #imageLiteral(resourceName: "A") 이거나 nil 이라면
        if imageView1.image == #imageLiteral(resourceName: "A") || imageView1.image == nil{
            print("1번 안올림")
        }else {
     let uploadImage1 = self.imageView1.image!  //이미지뷰1을 넣어줌
        
        Alamofire.upload(       //파일 upload
            multipartFormData: { multipartFormData in   //addImage
                self.addImageData(multipartFormData: multipartFormData,image: uploadImage1)
                // If you need to post many data, you need to sort with key.
                if let data = "userfile".data(using: String.Encoding.utf8) {    //encoding.utf8 로 인코딩
                    multipartFormData.append(data, withName: "file")    //file을 추가
                }
        },
            to: "Private/club/image/\(self.appDelegate.delegateClubnum)/1",
            //위임받은 델리게이트에 보낸다.
            headers: [Private],    //content type헤더 설정
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):    // request는 upload , 뒤의 매개변수는 _ 로 설정.
                    upload.responseString{ response in  //응답결과는 responseString
                        print (response)
                    }
                case .failure(let encodingError):   //실패시 에러인코딩
                    print(encodingError)
                }
            }
            )
        }
        //이미지뷰 이미지가 #imageLiteral(resourceName: "A")이거나 nil 이라면
        if imageView2.image == #imageLiteral(resourceName: "A") || imageView2.image == nil{
            print("2번 안올림")
        }else {
            let uploadImage2 = self.imageView2.image!   //이미지뷰2를 넣어줌
            
            Alamofire.upload(   //파일 upload
                multipartFormData: { multipartFormData in   //addImage
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage2)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {    //encoding.utf8로 인코딩
                        multipartFormData.append(data, withName: "file")    //file을 추가
                    }
            },
                to: "Private/club/image/\(self.appDelegate.delegateClubnum)/2",
                //위임받은 델리게이트에 보낸다.
                headers: [Private],    //context type 헤더설정
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):    //request는 upload, 나머지는 _, _ 로설정
                        upload.responseString{ response in  //응답은 responseString
                            print (response)
                        }
                    case .failure(let encodingError):   //실패시 인코딩에러
                        print(encodingError)
                    }
            }
            )
        }
        //이미지뷰 이미지가 #imageLiteral(resourceName: "A") 이거나 nil 이라면
        if imageView3.image == #imageLiteral(resourceName: "A") || imageView3.image == nil{
            print("3번 안올림")
        }else {
            let uploadImage3 = self.imageView3.image!   //이미지뷰3를 넣어줌
            
            Alamofire.upload(       //업로드
                multipartFormData: { multipartFormData in       //addImage
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage3)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {    //utf8로 인코딩
                        multipartFormData.append(data, withName: "file") //file을 추가
                    }
            },
                to: "Private/club/image/\(self.appDelegate.delegateClubnum)/3",
                //위임받은 델리게이트에 넣어준다.
                headers: ["Private"],    //헤더설정
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):    //request는 upload, 나머지는 _, _ 로설정
                        upload.responseString{ response in  //응답은 responseString
                            print (response)
                        }
                    case .failure(let encodingError):   //실패시 인코딩에러
                        print(encodingError)
                    }
            }
            )
        }
        //이미지뷰 이미지가 #imageLiteral(resourceName: "A") 이거나 nil 이라면
        if imageView4.image == #imageLiteral(resourceName: "A") || imageView4.image == nil{ 
            print("4번 안올림")
        }else {
            let uploadImage4 = self.imageView4.image!   //이미지뷰4넣어줌
            
            Alamofire.upload(   //upload
                multipartFormData: { multipartFormData in   //addImage
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage4)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {    //set utf8
                        multipartFormData.append(data, withName: "file")    //add file
                    }
            },
                to: "Private/club/image/\(self.appDelegate.delegateClubnum)/4",
                //델리게이트 찾기
                headers: ["Private"],    //content type 헤더 설정
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):    //request는 upload, 나머지는 _, _ 로설정
                        upload.responseString{ response in  //응답은 responseString
                            print (response)
                        }
                    case .failure(let encodingError):   //실패시 인코딩에러
                        print(encodingError)
                    }
            }
            )
        }
        self.view.makeToast("작동중입니다.")  //토스트 띄워줌
        let time = DispatchTime.now() + .seconds(3) //3초동안 띄워줌
        DispatchQueue.main.asyncAfter(deadline: time) { //비동기식으로 진행하는데 데드라인은 time만큼
            self.dataUpdate()   //데이터 업데이트 시켜줌
            self.navigationController?.popViewController(animated: true)    //이전 뷰 컨트롤러로 이동
        }

    }
    
    //삭제 버튼 구현
    @IBAction func deleteButton1(_ sender: Any) {
        NetworkManager.shared.deleteImage(num: "1"){ res in //deleteImage에 ,num=1로 삭제
            if let res = res{   //res 옵셔널 해제
                print(res)
            }
            if res == "400"{    //res==400
                self.view.makeToast("저장된 이미지가 없어요!")    //Toast
            }else {
                self.view.makeToast("사진삭제완료.")  //토스트 띄워줌
                self.imageView1.image = #imageLiteral(resourceName: "A")    //이미지 설정
                self.dataUpdate()   //데이터 업데이트
                }
            }
    }
    //삭제 버튼 구현
    @IBAction func deleteButton2(_ sender: Any) {
        NetworkManager.shared.deleteImage(num: "2"){ res in //deleteImage에 ,num=2로 삭제
            if let res = res{       //res 옵셔널 해제
                print(res)
            }
            if res == "400"{        //res==400
                self.view.makeToast("저장된 이미지가 없어요!")    //Toast
            }else {
                self.view.makeToast("사진삭제완료.")  //토스트 띄워줌
                self.imageView2.image = #imageLiteral(resourceName: "A")    //이미지 설정
                self.dataUpdate()   //데이터 업데이트
            }
        }
    }
    //삭제 버튼 구현
    @IBAction func deleteButton3(_ sender: Any) {
        NetworkManager.shared.deleteImage(num: "3"){ res in //deleteImage에 ,num=3로 삭제
            if let res = res{   //res 옵셔널 해제
                print(res)
            }
            if res == "Bad Request"{
                self.view.makeToast("저장된 이미지가 없어요!")    //Toast
            }else {
                self.view.makeToast("사진삭제완료.")  //Toast
                self.imageView3.image = #imageLiteral(resourceName: "A")    //이미지 설정
                self.dataUpdate()   //데이터 업데이트
            }
        }
    }
    //삭제 버튼 구현
    @IBAction func deleteButton4(_ sender: Any) {
        NetworkManager.shared.deleteImage(num: "4"){ res in //deleteImage에 ,num=4로 삭제
            if let res = res{   //res 옵셔널 해제
                print(res)
            }
            if res == "400"{
                self.view.makeToast("저장된 이미지가 없어요!")    //Toast
            }else {
                self.view.makeToast("사진삭제완료.")  //Toast
                self.imageView4.image = #imageLiteral(resourceName: "A")    //set Image
                self.dataUpdate()   //data update
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  createGradientLayer()   //그라데이션 함수 호출
        imageSetting()  //이미지 세팅 함수 호출
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //이미지 버튼1
    @IBAction func imageButton1(_ sender: Any) {
        imageView1.image = nil  //nil 초기화
        imagePicker.allowsEditing = false   //편집 사용하지 않음
        imagePicker.sourceType = .photoLibrary  //이미지 소스를 포토라이브러리로 지정
        present(imagePicker, animated: true, completion: nil)   //imagePicker로 이동
    }
    //이미지 버튼2
    @IBAction func imageButton2(_ sender: Any) {
        imageView2.image = nil  //nil 초기화
        imagePicker.allowsEditing = false   //편집 사용하지 않음
        imagePicker.sourceType = .photoLibrary  //이미지 소스를 포토 라이브러리로 지정
        present(imagePicker, animated: true, completion: nil)   //imagePicker로 이동
    }
    //이미지 버튼3
    @IBAction func imageButton3(_ sender: Any) {
        imageView3.image = nil  //nil 초기화
        imagePicker.allowsEditing = false   //편집 사용하지 않음
        imagePicker.sourceType = .photoLibrary  //이미지 소스를 포토 라이브러리로 지정
        present(imagePicker, animated: true, completion: nil)   //imagePicker로 이동
    }
    //이미지 버튼4
    @IBAction func imageButton4(_ sender: Any) {
        imageView4.image = nil  //nil 초기화
        imagePicker.allowsEditing = false   //편집 사용하지 않음
        imagePicker.sourceType = .photoLibrary  //이미지 소스를 포토 라이브러리로 지정
        present(imagePicker, animated: true, completion: nil)   //imagePicker로 이동
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //UIImage로 옵셔널 묵시적 해제
            selectedImage = originalImage   //selectImage에 넣어줌.
            if imageView1.image == nil{     //nil 이라면 orginalImage를 넣어줌
            imageView1.image = originalImage
            }
            if imageView2.image == nil{     //nil 이라면 orginalImage를 넣어줌
                imageView2.image = originalImage
            }
            if imageView3.image == nil{     //nil 이라면 orginalImage를 넣어줌
                imageView3.image = originalImage
            }
            if imageView4.image == nil{     //nil 이라면 orginalImage를 넣어줌
                imageView4.image = originalImage
            }
        }
        
        dismiss(animated: true, completion: nil)    //이전화면으로 복귀
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)    //이전화면으로 복귀
    }
    //이미지 세팅 메소드
    func imageSetting() {
        let clubNum:Int = Int(self.appDelegate.delegateClubnum)!    //Int형으로 형변환
        clubDetail = DBManager.shared.getClubinfo(num: clubNum) //getClubinfo에서 clubNum으로 필터링
        print(clubDetail)
        
        let image1 = clubDetail[0]["image1"]    //clubDetail의 1행 1열
        let image2 = clubDetail[0]["image2"]    //clubDetail의 1행 2열
        let image3 = clubDetail[0]["image3"]    //clubDetail의 1행 3열
        let image4 = clubDetail[0]["image4"]    //clubDetail의 1행 4열
        
        //image1이 nil 이면 #imageLiteral(resourceName: "A") 그림 넣어줌
        if image1 == nil {
            imageView1.image = #imageLiteral(resourceName: "A")
        } else {

            let logo1 = URL(string: "Private")
            //로고의 url주고, KingFisher를 사용하여 웹에있는 이미지를 가져옴
            imageView1.kf.setImage(with: logo1)
        }
        //image1이 nil 이면 #imageLiteral(resourceName: "A") 그림 넣어줌
        if image2 == nil {
            imageView2.image = #imageLiteral(resourceName: "A")
        } else {
            let logo2 = URL(string: "Private")
            //로고의 url주고, KingFisher를 사용하여 웹에있는 이미지를 가져옴
            imageView2.kf.setImage(with: logo2)
        }
        //image1이 nil 이면 #imageLiteral(resourceName: "A") 그림 넣어줌
        if image3 == nil {
            imageView3.image = #imageLiteral(resourceName: "A")
        } else {
            let logo3 = URL(string: "Private")
            //로고의 url주고, KingFisher를 사용하여 웹에있는 이미지를 가져옴
            imageView3.kf.setImage(with: logo3)
        }
        //image1이 nil 이면 #imageLiteral(resourceName: "A") 그림 넣어줌
        if image4 == nil {
            imageView4.image = #imageLiteral(resourceName: "A")
        } else {
            let logo4 = URL(string: "Private")
            //로고의 url주고, KingFisher를 사용하여 웹에있는 이미지를 가져옴
            imageView4.kf.setImage(with: logo4)
        }

    }
    //그라데이션 생성 메소드
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()   //객체 생성
        
        gradientLayer.frame = self.view.bounds  //프레임을 뷰의 바운드로 설정
        
        //그라데이션 from - to 설정
        gradientLayer.colors = [UIColor(red: 97.0 / 255.0, green: 144.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor,
                                UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0 , blue: 232.0 / 255.0, alpha: 1.0).cgColor]
        //그라데이션은 위에서 아래방향으로
        gradientLayer.locations = [0.0, 1.0]
        //그라데이션 배경의 입체도. 다른 뷰와 섞이지않게 -1 로 설정
        gradientLayer.zPosition = -1
        //그라데이션레이어 뷰를 추가
        self.view.layer.addSublayer(gradientLayer)
        
    }
 
    private func addImageData(multipartFormData: MultipartFormData, image: UIImage!){
        var data = UIImagePNGRepresentation(image!) // Image를 PNG로 표현한다
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: "userfile",fileName: "userfile", mimeType: "image/png")
            //multipartFormData에 추가 userfile에 넣고 타입은 image/png
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 0.7)   //Image를 JPEG로 표현한다
            multipartFormData.append((data?.base64EncodedData())!, withName: "userfile",fileName: "userfile", mimeType: "image/jpeg")   //multipartFormData에 추가 userfile에 넣고 타입은 image/jpeg
        }
        
    }
    //data update
    func dataUpdate() {
        DBManager.shared.deleteAll()    //DB에 있는거 전부 삭제
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {  //error 옵셔널 해제
                print(error)    //error 출력
            }
            if let contacts = contacts {    //contact 옵셔널 해제
                DBManager.shared.saveContact(array: contacts)   //DB에 써줌
            }
            
        }
// smallgroup getter
        
//        NetworkManager.shared.getSmallgroup{ smallgroup, error in
//            if let error = error {  //error 옵셔널 해제
//                print(error)    //error 출력
//            }
//            if let smallgroup = smallgroup {
//                DBManager.shared.saveSmallGroup(array: [smallgroup])
//            }
//        }
        
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {  //error 옵셔널 해제
                print(error)    //error 출력
            }
            if let contactsimg = contactsimg{   //conatactsimg 옵셔널 해제
                DBManager.shared.saveMainImg(array: contactsimg)    //DB에 써줌
            }
        }
        
        NetworkManager.shared.getContactsEventList{ contactsevent, error in
            if let error = error {  //error 옵셔널 해제
                print(error)    //error 출력
            }
            if let contactsevent = contactsevent {  //contactsevent 옵셔널 해제
                DBManager.shared.saveEventList(array: contactsevent)    //DB에 써줌
                
                print(contactsevent, "event")
            }
        }
    }
}
