//
//  ProfileVC.swift
//  Rijlesboeken
//
//  Created by Prince on 27/04/22.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    @IBOutlet weak var vw_TopView: UIView!{
        didSet{
            vw_TopView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var btn_Edit: UIButton!{
        didSet{
            btn_Edit.layer.cornerRadius = btn_Edit.layer.frame.height / 2
        }
    }
    @IBOutlet weak var vw_ProfileBg: UIView!
    @IBOutlet weak var vw_profileBgView: UIView!{
        didSet{
            vw_profileBgView.layer.cornerRadius = 40.0
        }
    }
    @IBOutlet weak var vw_studentDetailsBgView: UIView!
    @IBOutlet weak var myActivimgBg: UIImageView!
    @IBOutlet weak var myPicimgBg: UIImageView!
    @IBOutlet weak var myInvoicimgBg: UIImageView!
    @IBOutlet weak var privacyimgBg: UIImageView!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var lbl_studentName: UILabel!
    @IBOutlet weak var lbl_gmail: UILabel!
    @IBOutlet weak var lbl_ContactNumber: UILabel!
    
    @IBOutlet weak var vw_1BG: UIView!
    @IBOutlet weak var vw_2BG: UIView!
    @IBOutlet weak var vw_3BG: UIView!
    @IBOutlet weak var vw_4BG: UIView!
    
    var validationStatus:Bool?
   // var phone = UserDefaults.standard.value(forKey: "PhoneNo")
//    print("Phone no:",phone)

    
   // var userData1 = profileDataStruct?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Shadow.add(view: vw_profileBgView, color: .lightGray)
        Shadow.add(view: vw_1BG, color: .lightGray)
        Shadow.add(view: vw_2BG, color: .lightGray)
        Shadow.add(view: vw_3BG, color: .lightGray)
        Shadow.add(view: vw_4BG, color: .lightGray)
        Shadow.add(view: vw_studentDetailsBgView, color: .lightGray)
        self.vw_ProfileBg.layer.cornerRadius = self.vw_ProfileBg.layer.frame.height / 2
        self.vw_studentDetailsBgView.layer.cornerRadius = 10.0
        self.profileimg.layer.cornerRadius = self.profileimg.layer.frame.height / 2
        
        self.vw_1BG.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft], radius: 25)
        self.vw_2BG.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft], radius: 25)
        self.vw_3BG.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft], radius: 25)
        self.vw_4BG.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft], radius: 25)
   }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if let userId = UserDefaults.standard.value(forKey: "user_id"){
            print(userId)
            self.profilesApi()
        }else{
            print("No User iD")
            self.loginDtls()
          
        }
    }
    
    
    @IBAction func act_Notification(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "user_id") != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            print("No Logged")
            
        }
        
    }
    @IBAction func act_Search(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "user_id") != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerListVC") as? TrainerListVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            print("No Logged")
            
        }
    }
    
    @IBAction func act_Login(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_EditDetails(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile") as? EditProfile
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_MyActivePackages(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyActivePackVC") as? MyActivePackVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_MyPickLocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPickupLocationVC") as? MyPickupLocationVC
        addressStatus = "0"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_MyInvoices(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyInvoiceVC") as? MyInvoiceVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Privacy(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyVC") as? PrivacyVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Logout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Logout" , style: .default){ (_ action) in
            self.logoutApi()
           
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
    
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
        
        
    }
  
    func loginDtls(){
        let alertController = UIAlertController(title: "Login Require", message: "You have not login yet. Please login.", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
           self.navigationController?.pushViewController(updateProfileVC, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }

        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }

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
                print("UserId:",userId ?? 0)
                let name = "\(user?.first_name ?? "")" + " \(user?.last_name ?? "")"
                UserDefaults.standard.set(name, forKey: "name")
                print("User Name:",name)
                self.lbl_studentName.text = name
                self.lbl_gmail.text = user?.email
                
                self.lbl_ContactNumber.text = user?.phone
                
                //self.profileimg.image = user?.image
//                        SDImageCache.shared.clearMemory()
//                        SDImageCache.shared.clearDisk()
                let img_Url = user?.image
                self.profileimg.sd_setImage(with: URL(string:img_Url!),
                    placeholderImage: UIImage(named: "img"))
                print("Response code:",responseCode ?? 0)
                print("Response text:",responseText ?? "")
//                switch responseCode {
//                case 1:
//                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
//                case 0:
//                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password")
//                default:
//                   ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
//                }
            }
        }
    }

    /*
    
    func logout(){
        let alertController = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Logout" , style: .default){ (_ action) in
            
           // self.logoutApi()
            
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC

            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
    
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
     */
    
    func logoutApi(){
        let parameters:[String:Any] = [:]
        LogoutDataResponse.AddUserData(api: "auth/logout", parameters: parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let respoceData = data?.responseData
                let responseText = data?.responseText
                debugPrint(respoceData as Any)
                switch responseCode {
                case 1:
                    
                    UserDefaults.standard.set(false, forKey: "user_id")
                    UserDefaults.standard.removeObject(forKey: "user_id")
                    UserDefaults.standard.set(false, forKey: "Token")
                    UserDefaults.standard.removeObject(forKey: "Token")
                    self.navigationController!.popToViewController(self, animated: true)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                    self.hidesBottomBarWhenPushed = true
                          self.navigationController?.pushViewController(vc!, animated: true)
                 //   ApiService.shared.showAlert(title: "", msg: "Logout sucessfully")
                    self.hidesBottomBarWhenPushed = true
                    let vcCount = self.navigationController!.viewControllers.count
                    print(vcCount)
                    self.validationStatus = false
                    
                    
                    
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                case 0:
                    ApiService.shared.showAlert(title: "", msg:  "\(responseText ?? "")")
                default:
                   ApiService.shared.showAlert(title: "", msg: "Somthing went wrong" )
                }
            }
        }
    }
    
}

