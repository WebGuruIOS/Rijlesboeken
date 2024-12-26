//
//  LoginVC.swift
//  Rijlesboeken
//
//  Created by Prince on 30/04/22.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var vw_BackBgView: UIView!
    @IBOutlet weak var btn_Eye: UIButton!
    @IBOutlet weak var vw_EmailBgVIew: UIView!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var vw_PsdBgView: UIView!
    @IBOutlet weak var vw_LoginBg: UIView!
    @IBOutlet weak var txt_Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        vw_LoginBg.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        self.vw_BackBgView.layer.cornerRadius = 40.0
        self.vw_EmailBgVIew.layer.cornerRadius = self.vw_EmailBgVIew.layer.frame.height / 2
        self.vw_PsdBgView.layer.cornerRadius = self.vw_PsdBgView.layer.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func act_Back(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//                self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController!.popToViewController(self, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        hidesBottomBarWhenPushed = true
              self.navigationController?.pushViewController(vc!, animated: true)
        hidesBottomBarWhenPushed = true
        let vcCount = self.navigationController!.viewControllers.count
    }
    
    @IBAction func act_Eyes(_ sender: Any) {
        if btn_Eye.isSelected{
            btn_Eye.isSelected = false
            txt_Password.isSecureTextEntry = true
        }else{
            btn_Eye.isSelected = true
            txt_Password.isSecureTextEntry = false
        }
    }
    @IBAction func act_Login(_ sender: Any) {
      
        
        guard let email = txt_Email.text, email != "" else {
            ApiService.shared.showAlert(title: "", msg: "Please Your Enter Email")
            return
        }
        if  isValidEmail(email: txt_Email.text!){
        }else{
            ApiService.shared.showAlert(title: "", msg: "Invalid email")
        }
        guard let pass = txt_Password.text, pass != "" else {
            ApiService.shared.showAlert(title: "", msg: "Please enter your password")
            return
        }
        if Connectivity.isConnectedToInternet() {
            self.loginApi()
            
        }else{
            ApiService.shared.showAlert(title: "Attention!", msg: "Please Check Your internet connection!!")
    }
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//        hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_ForgotPsd(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotVC") as? ForgotVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func actSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func loginApi(){
        let parameters:[String:Any] = ["email":txt_Email.text!,"password":txt_Password.text! ,"user_type":"user"]
       // ACProgressHUD.shared.showHUD()
        LoginDataResponce.AddUserData(api: "auth/login", parameters: parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let respoceData = data?.responseData
                let userData = respoceData?.user
                if let userid = userData?.user_id{
                UserDefaults.standard.set(userid, forKey: "user_id")
                    print("Id:",userid)
                }
                if let token = respoceData?.token{
                    UserDefaults.standard.setValue(token, forKey: "Token")
                }
                
                print(respoceData as Any)
                switch responseCode {
                case 1:
                    self.navigationController!.popToViewController(self, animated: true)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                    self.hidesBottomBarWhenPushed = true
                          self.navigationController?.pushViewController(vc!, animated: true)
                    self.hidesBottomBarWhenPushed = true
                    let vcCount = self.navigationController!.viewControllers.count
                    let responseText = data?.responseText ?? ""
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password")
                default:
                   ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
}

extension LoginVC: UITextFieldDelegate{
        func textFieldDidBeginEditing(_ textField: UITextField) {
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.txt_Email.resignFirstResponder()
            self.txt_Password.resignFirstResponder()
            return true
        }
    }
