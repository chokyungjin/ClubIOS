//
//  ClubMake2ViewController.swift
//  club_INU
//
//  Created by 황동주 on 2018. 1. 24..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class ClubImageViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    var gradientLayer: CAGradientLayer!
    lazy var imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedImage: UIImage?
    
    var clubDetail: [Contact] = []

    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    
    @IBAction func sendButton(_ sender: Any) {

        if imageView1.image == #imageLiteral(resourceName: "A") || imageView1.image == nil{
            print("1번 안올림")
        }else {
     let uploadImage1 = self.imageView1.image!
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                self.addImageData(multipartFormData: multipartFormData,image: uploadImage1)
                // If you need to post many data, you need to sort with key.
                if let data = "userfile".data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: "file")
                }
        },
            to: "http://appcenter.us.to:3303/club/image/\(self.appDelegate.delegateClubnum)/1",
            headers: ["Content-Type" : "application/x-www-form-urlencoded"],
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString{ response in
                        print (response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
            )
        }
        
        if imageView2.image == #imageLiteral(resourceName: "A") || imageView2.image == nil{
            print("2번 안올림")
        }else {
            let uploadImage2 = self.imageView2.image!
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage2)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {
                        multipartFormData.append(data, withName: "file")
                    }
            },
                to: "http://appcenter.us.to:3303/club/image/\(self.appDelegate.delegateClubnum)/2",
                headers: ["Content-Type" : "application/x-www-form-urlencoded"],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString{ response in
                            print (response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
        }
        
        if imageView3.image == #imageLiteral(resourceName: "A") || imageView3.image == nil{
            print("3번 안올림")
        }else {
            let uploadImage3 = self.imageView3.image!
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage3)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {
                        multipartFormData.append(data, withName: "file")
                    }
            },
                to: "http://appcenter.us.to:3303/club/image/\(self.appDelegate.delegateClubnum)/3",
                headers: ["Content-Type" : "application/x-www-form-urlencoded"],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString{ response in
                            print (response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
        }
        
        if imageView4.image == #imageLiteral(resourceName: "A") || imageView4.image == nil{
            print("4번 안올림")
        }else {
            let uploadImage4 = self.imageView4.image!
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    self.addImageData(multipartFormData: multipartFormData,image: uploadImage4)
                    
                    // If you need to post many data, you need to sort with key.
                    if let data = "userfile".data(using: String.Encoding.utf8) {
                        multipartFormData.append(data, withName: "file")
                    }
            },
                to: "http://appcenter.us.to:3303/club/image/\(self.appDelegate.delegateClubnum)/4",
                headers: ["Content-Type" : "application/x-www-form-urlencoded"],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString{ response in
                            print (response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
        }
        self.view.makeToast("작동중입니다.")
        let time = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.dataUpdate()
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGradientLayer()
        imageSetting()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imageButton1(_ sender: Any) {
        imageView1.image = nil
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func imageButton2(_ sender: Any) {
        imageView2.image = nil
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func imageButton3(_ sender: Any) {
        imageView3.image = nil
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func imageButton4(_ sender: Any) {
        imageView4.image = nil
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = originalImage
            if imageView1.image == nil{
            imageView1.image = originalImage
            }
            if imageView2.image == nil{
                imageView2.image = originalImage
            }
            if imageView3.image == nil{
                imageView3.image = originalImage
            }
            if imageView4.image == nil{
                imageView4.image = originalImage
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imageSetting() {
        let clubNum:Int = Int(self.appDelegate.delegateClubnum)!
        clubDetail = DBManager.shared.getClubinfo(num: clubNum)
        print(clubDetail)
        
        let image1 = clubDetail[0]["image1"]
        let image2 = clubDetail[0]["image2"]
        let image3 = clubDetail[0]["image3"]
        let image4 = clubDetail[0]["image4"]
        
        if image1 == nil {
            imageView1.image = #imageLiteral(resourceName: "A")
        } else {
            let logo1 = URL(string: "http://appcenter.us.to:3303/club/image/\(image1!)")
            imageView1.kf.setImage(with: logo1)
        }
        
        if image2 == nil {
            imageView2.image = #imageLiteral(resourceName: "A")
        } else {
            let logo2 = URL(string: "http://appcenter.us.to:3303/club/image/\(image2!)")
            imageView2.kf.setImage(with: logo2)
        }
        
        if image3 == nil {
            imageView3.image = #imageLiteral(resourceName: "A")
        } else {
            let logo3 = URL(string: "http://appcenter.us.to:3303/club/image/\(image3!)")
            imageView3.kf.setImage(with: logo3)
        }
        
        if image4 == nil {
            imageView4.image = #imageLiteral(resourceName: "A")
        } else {
            let logo4 = URL(string: "http://appcenter.us.to:3303/club/image/\(image4!)")
            imageView4.kf.setImage(with: logo4)
        }

    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red: 97.0 / 255.0, green: 144.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor,
                                UIColor(red: 166.0 / 255.0, green: 191.0 / 255.0 , blue: 232.0 / 255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.zPosition = -1
        self.view.layer.addSublayer(gradientLayer)
        
    }
 
    private func addImageData(multipartFormData: MultipartFormData, image: UIImage!){
        var data = UIImagePNGRepresentation(image!)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: "userfile",fileName: "userfile", mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 0.7)
            multipartFormData.append((data?.base64EncodedData())!, withName: "userfile",fileName: "userfile", mimeType: "image/jpeg")
        }
        
    }
    
    func dataUpdate() {
        
        DBManager.shared.deleteAll()
        NetworkManager.shared.getContacts{ contacts, error in
            if let error = error {
                print(error)
            }
            if let contacts = contacts {
                DBManager.shared.saveContact(array: contacts)
            }
        }
        NetworkManager.shared.getContactsMainImg{ contactsimg, error in
            if let error = error {
                print(error)
            }
            if let contactsimg = contactsimg{
                DBManager.shared.saveMainImg(array: contactsimg)
            }
        }
        NetworkManager.shared.getContactsEventList{ contactsevent, error in
            if let error = error {
                print(error)
            }
            if let contactsevent = contactsevent {
                DBManager.shared.saveEventList(array: contactsevent)
                
                print(contactsevent, "event")
            }
        }
    }
}
