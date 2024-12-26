//
//  PrivacyVC.swift
//  Rijlesboeken
//
//  Created by Prince on 11/05/22.
//

import UIKit

class PrivacyVC: UIViewController {
    
    @IBOutlet weak var vw_OldPsd: UIView!
    @IBOutlet weak var vw_NewPsd: UIView!
    @IBOutlet weak var vw_ConfirmPsd: UIView!
    @IBOutlet weak var vw_BgView: UIView!
    
    @IBOutlet weak var txt_OldPsd: UITextField!
    @IBOutlet weak var txt_NewPsd: UITextField!
    @IBOutlet weak var txt_ConfirmPsd: UITextField!
    
    @IBOutlet weak var btn_OldPsd: UIButton!
    @IBOutlet weak var btn_NewPsd: UIButton!
    @IBOutlet weak var btn_EyeConfirmPsd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        vw_BgView.layer.cornerRadius = 40.0
        vw_OldPsd.layer.cornerRadius = vw_OldPsd.layer.frame.height / 2
        vw_NewPsd.layer.cornerRadius = vw_NewPsd.layer.frame.height / 2
        vw_ConfirmPsd.layer.cornerRadius = vw_ConfirmPsd.layer.frame.height / 2
        
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_OldPsd(_ sender: Any) {
        if btn_OldPsd.isSelected{
            btn_OldPsd.isSelected = false
            txt_OldPsd.isSecureTextEntry = true
        }else{
            btn_OldPsd.isSelected = true
            txt_OldPsd.isSecureTextEntry = false
        }
        
    }
    @IBAction func act_NewPsd(_ sender: Any) {
        if btn_NewPsd.isSelected {
            self.btn_NewPsd.isSelected = false
            self.txt_NewPsd.isSecureTextEntry = true
        }else{
            self.btn_NewPsd.isSelected = true
            self.txt_NewPsd.isSecureTextEntry = false
        }
        
    }
    
    @IBAction func act_ConfirmPsd(_ sender: Any) {
        if btn_EyeConfirmPsd.isSelected{
            btn_EyeConfirmPsd.isSelected = false
            txt_ConfirmPsd.isSecureTextEntry = true
        }else{
            btn_EyeConfirmPsd.isSelected = true
            txt_ConfirmPsd.isSecureTextEntry = false
        }
    }
    
    @IBAction func act_Save(_ sender: Any) {
        self.txt_NewPsd.resignFirstResponder()
        self.txt_OldPsd.resignFirstResponder()
        self.txt_ConfirmPsd.resignFirstResponder()
        
        guard let oldPass = txt_OldPsd.text, oldPass != "" else {
            ApiService.shared.showAlert(title: "", msg: "Please  Enter Your Old password")
            return
        }
        guard let newPass = txt_NewPsd.text, newPass != "" else {
            ApiService.shared.showAlert(title: "", msg: "Please  Enter Your New password")
            return
        }
        
        guard let confPass = txt_ConfirmPsd.text, confPass != "" else {
            ApiService.shared.showAlert(title: "", msg: "Please  Enter Your Confirm password")
            return
        }
        
        if txt_NewPsd.text != txt_ConfirmPsd.text{
            ApiService.shared.showAlert(title: "", msg: "New password and Confirm password not matched")
        }else{
            self.changePasswordApi()
        }
    }
    
    //changePasswordApi
    func changePasswordApi() {
        let parameters:[String:Any] = ["old_password":txt_OldPsd.text!,"new_password":txt_NewPsd.text!]
        ChangePsdDataResponse.AddUserData(api: "changePassword", parameters: parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                switch responseCode {
                case 1:
                    let responseText = data?.responseText
                    self.navigationController?.popViewController(animated: true)
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "" )
                    self.navigationController?.popViewController(animated: true)
                case 0:
                    let responseText = data?.responseText
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                default:
                    let responseText = data?.responseText
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                }
            }
        }
    }
}

