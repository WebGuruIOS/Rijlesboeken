//
//  EditProfile.swift
//  Rijlesboeken
//
//  Created by Prince on 02/05/22.
//

import UIKit
import Alamofire
import SDWebImage

class EditProfile: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var vw_BgUpdate: UIView!
    
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_PhoneNumber: UITextField!
    @IBOutlet weak var txt_Age: UITextField!
    @IBOutlet weak var vw_DetailBgView: UIView!
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_FistnameBgView: UIView!
    @IBOutlet weak var vw_LastNameBgView: UIView!
    @IBOutlet weak var vw_ContactBgView: UIView!
    @IBOutlet weak var vw_AgeBgView: UIView!
    @IBOutlet weak var btn_Editimg: UIButton!
    let customerId = UserDefaults.standard.string(forKey: "user_id") ?? ""
//    var imagePick: ImagePicker!
//    var str_profilePic:String = ""
//    var userImage:UIImage?
    
    let imagePicker = UIImagePickerController()
    var image = UIImage(named:"")
    var str_profImg:String?
    var profileImage:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        vw_BgUpdate.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        Shadow.add(view: vw_DetailBgView, color: .lightGray)
        Shadow.add(view: imgBgView, color: .lightGray)
        vw_DetailBgView.layer.cornerRadius = 10.0
        vw_BgView.layer.cornerRadius = 40.0
        vw_FistnameBgView.layer.cornerRadius = vw_FistnameBgView.layer.frame.height / 2
        vw_LastNameBgView.layer.cornerRadius = vw_LastNameBgView.layer.frame.height / 2
        vw_ContactBgView.layer.cornerRadius = vw_ContactBgView.layer.frame.height / 2
        vw_AgeBgView.layer.cornerRadius = vw_AgeBgView.layer.frame.height / 2
        btn_Editimg.layer.cornerRadius = btn_Editimg.layer.frame.height / 2
        imgBgView.layer.cornerRadius = imgBgView.layer.frame.width / 2
        imgView.layer.cornerRadius = imgView.layer.frame.width / 2
       // self.imagePick = ImagePicker(presentationController: self, delegate: self)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("ImageURL :",str_profImg ?? "")
        self.setProfileimg(img:str_profImg ?? "")
        self.profilesApi()
//        DispatchQueue.main.async {
//            if let imageUrl:URL = URL(string: "\(self.str_profilePic)"){
//                self.imgView.sd_setImage(with:imageUrl)
//               // self.imgView.sd_imageURL.setImage(with: imageUrl)
//            }
//        }
    }

    @IBAction func act_Back(_ sender: Any) {
        SDImageCache.shared.clearMemory()
      //  SDImageCache.shared.clearDisk()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_EditPhoto(_ sender: UIButton) {
       // self.imagePick.present(from: sender)
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func act_Update(_ sender: Any) {
        updateProfileApi()
        SDImageCache.shared.clearMemory()
       // SDImageCache.shared.clearDisk()
      
    }
    
    //Profile Api
    func profilesApi() {
        let parameters:[String:Any] = [:]
        ProfileDataResponse.AddUserData(api: "getProfile", parameters:parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.status
                let responseText = data?.msg
                let userData1 = data?.payload
                let user = userData1?.user
                let userId = user?.user_id
                debugPrint("UserId:",userId ?? 0)
                debugPrint(responseCode ?? 0)
                debugPrint(responseText ?? "")
                self.txt_FirstName.text = user?.first_name
                self.txt_LastName.text = user?.last_name
                self.txt_PhoneNumber.text = user?.phone
                self.txt_Age.text = String(user?.age ?? 0)
                let img_Url = user?.image
                self.imgView.sd_setImage(with: URL(string:img_Url!),
                placeholderImage: UIImage(named: "img"))
            }
        }
    }
    
    // Profile Update Api
    func updateProfileApi() {
        let parameters:[String:Any] = ["first_name":txt_FirstName.text!,"last_name":txt_LastName.text!,"phone":txt_PhoneNumber.text!,"age":txt_Age.text!,"location_id":""]
        debugPrint("ParasValue:",parameters)
        UpdateProfileResponse.AddUserData(api: "updateProfile", parameters:parameters){
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                debugPrint(responseCode ?? 0)
                debugPrint(responseText ?? "")
                switch responseCode {
                case 1:
                    self.navigationController?.popViewController(animated: true)
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                }
            }
        }
    }
    // Image Uploading works
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage{
            selectedImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage{
            selectedImage = originalImage
        }
        if let selectedImages = selectedImage{
            self.profileImage = selectedImages
            self.imgView.image = profileImage
            self.multiFormImageUploadApi(imageFile:self.profileImage!)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Camera Setting
    func setProfileimg(img:String){
        if let imageUrl:URL = URL(string:"\(img)") {
           // self.imgView.sd_setImage(with: imageUrl, completed: nil)
            self.imgView.sd_setImage(with: imageUrl, completed: nil)
           
        }    }
    
    func multiFormImageUploadApi(imageFile:UIImage){
       // SVProgressHUD.show(withStatus: "Loading")
        let parameters = ["user_id": customerId]
        let baseUrl1 = baseURL + "updateProfilePic"
       let token = UserDefaults.standard.value(forKey: "Token")
        var header:HTTPHeaders = [:]
        header["contentType"] = "application/json"
        header = ["Authorization": "Bearer \(token ?? "")"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageData1 = imageFile.jpegData(compressionQuality: 0.5)
            multipartFormData.append(imageData1!, withName: "image",fileName: "file.png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
               // multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
        to:baseUrl1,headers:header)
        { (result) in
            switch result {
            case .success(let upload, _, _):
            upload.responseJSON { response in
                   // SVProgressHUD.dismiss()
                debugPrint(response.result.value ?? "")
                    let alertController = UIAlertController(title:nil,message:" Image upload sucessfull",preferredStyle:.alert)
                    self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 1, repeats:false, block: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })})
                }
            case.failure(let encodingError):
                debugPrint(encodingError)
              //  SVProgressHUD.dismiss()
            }
        }
    }
    
}

