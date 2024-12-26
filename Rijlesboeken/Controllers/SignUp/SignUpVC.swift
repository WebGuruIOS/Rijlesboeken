//
//  SignUpVC.swift
//  Rijlesboeken
//
//  Created by Prince on 11/05/22.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_FirstName: UIView!
    @IBOutlet weak var vw_LastNameBg: UIView!
    @IBOutlet weak var vw_AgeBG: UIView!
    @IBOutlet weak var vw_EmailBg: UIView!
    @IBOutlet weak var vw_PsdBg: UIView!
    
    @IBOutlet weak var vw_nextBGView: UIView!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_Age: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Psd: UITextField!
    @IBOutlet weak var btn_EyePsd: UIButton!
    var validInput:Bool = false

    var otpValue:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        vw_nextBGView.roundCorners(corners: [.bottomLeft, .topRight, .bottomRight], radius: 25)
        vw_BgView.layer.cornerRadius = 40.0
        vw_FirstName.layer.cornerRadius = vw_FirstName.layer.frame.height / 2
        vw_LastNameBg.layer.cornerRadius = vw_LastNameBg.layer.frame.height / 2
        vw_AgeBG.layer.cornerRadius = vw_AgeBG.layer.frame.height / 2
        vw_EmailBg.layer.cornerRadius = vw_EmailBg.layer.frame.height / 2
        vw_PsdBg.layer.cornerRadius = vw_PsdBg.layer.frame.height / 2
        
//        self.txt_Age.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
//        self.txt_Psd.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
//        self.txt_FirstName.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
//        self.txt_LastName.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
//        self.txt_Email.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        
    }
    
//    @objc func tapDone(sender: Any) {
//           self.view.endEditing(true)
//       }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func act_SignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Next(_ sender: Any) {
        
        validInput = true
        
        self.txt_FirstName.resignFirstResponder()
        self.txt_LastName.resignFirstResponder()
        self.txt_Email.resignFirstResponder()
        self.txt_Age.resignFirstResponder()
        self.txt_Psd.resignFirstResponder()

        if txt_FirstName.text == ""{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your first name", buttonLabel:"Ok")
        }else if txt_FirstName.text!.count < 3 {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter correct  first name", buttonLabel:"Ok")
        }
          
        if isValid(testStr:txt_FirstName.text!){
            print("Valid firstName")
        }else{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your valid first name.", buttonLabel:"Ok")
        }
         
        if txt_LastName.text == ""{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your last name", buttonLabel:"Ok")
        }else if txt_LastName.text!.count < 3 {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter correct last name", buttonLabel:"Ok")
        }
        
        if isValid(testStr:txt_LastName.text!){
            print("Valid lastName")
        }else{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your valid last name.", buttonLabel:"Ok")
        }
        
        if txt_Age.text == ""{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your age", buttonLabel:"Ok")
        }else if txt_Age.text!.count == 0{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Age should not be 0", buttonLabel:"Ok")
        
         if txt_Email.text == ""{
             validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter your email", buttonLabel:"Ok")
         }else if isValidEmail(email:txt_Email.text!){
             print("Valid email")
        }else{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter valid email", buttonLabel:"Ok")
        }
   }
        if txt_Psd.text == ""{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter password", buttonLabel:"Ok")
       }
        
        //      else if txt_Psd.text!.count < 7 {
        //            self.alertDisplay(titleMsg:"", displayMessage:" Password length should be grater than 7", buttonLabel:"Ok")
        //        }
        
        //        let parameters:[String:Any] = ["first_name":txt_FirstName.text!,"last_name":txt_LastName.text!,"email":txt_Email.text!,"age":"\(txt_Age.text!)","password": "\(txt_Psd.text!)","user_type":"user"]
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as? OtpVerifyVC
        //        print("Parameters:",parameters)
        //        vc!.params = parameters
        if validInput{
            self.sendOtpApi()
        }
        
        //self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_ShowPsd(_ sender: Any) {
        if btn_EyePsd.isSelected{
            btn_EyePsd.isSelected = false
            txt_Psd.isSecureTextEntry = true
        }else{
            btn_EyePsd.isSelected = true
            txt_Psd.isSecureTextEntry = false
        }
    }
    
     func sendOtpApi(){
        let paramValues:[String:Any] = ["first_name":txt_FirstName.text!,"last_name":txt_LastName.text!,"email":txt_Email.text!,"age":"\(txt_Age.text!)","password": "\(txt_Psd.text!)","user_type":"user"]
        let parameters:[String:Any] = ["email" : txt_Email.text!]
        OtpDataResponce.AddUserData(api: "sendOtp", parameters: parameters) {
             (data) in
             if data != nil {
                 let responceCode = data?.responseCode
                let responseText = data?.responseText
                 if let data = data?.responseData{
                    self.otpValue = data.otp ?? 0
                    print("OptValue:",self.otpValue)
                 }else{
                    print("No value")
                 }
                switch responceCode {
                case 1:
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as? OtpVerifyVC
                    vc!.email = self.txt_Email.text!
                     vc!.otpvfy = self.otpValue
                    vc!.emailOtp = self.txt_Email.text!
                    vc!.params = paramValues
                    
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                default:
                   ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                }
             }
         }
     }
}

extension SignUpVC: UITextFieldDelegate{
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
            self.txt_FirstName.resignFirstResponder()
            self.txt_LastName.resignFirstResponder()
            self.txt_Email.resignFirstResponder()
            self.txt_Psd.resignFirstResponder()
            self.txt_Age.resignFirstResponder()
            return true
        }
}

//extension UITextField {
//    open override func awakeFromNib() {
//        if let vc = self.SignUpVC() as? UITextFieldDelegate {
//            self.delegate = vc
//        }
//    }
//}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,y: 0.0,width: UIScreen.main.bounds.size.width,height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }

}
