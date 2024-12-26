//
//  ForgotVC.swift
//  Rijlesboeken
//
//  Created by Prince on 30/04/22.
//

import UIKit

class ForgotVC: UIViewController {
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var vw_EmailBgView: UIView!
    @IBOutlet weak var vw_SubmitBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        vw_SubmitBG.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        vw_BgView.layer.cornerRadius = 40.0
        vw_EmailBgView.layer.cornerRadius = vw_EmailBgView.layer.frame.height / 2
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Submit(_ sender: Any) {
        self.txt_Email.resignFirstResponder()
        if txt_Email.text == ""{
           self.alertDisplay(titleMsg:"", displayMessage:"Enter your email", buttonLabel:"Ok")
        }else if isValidEmail(email:txt_Email.text!){
       }else{
           self.alertDisplay(titleMsg:"", displayMessage:"Enter valid email", buttonLabel:"Ok")
       }
        self.forgotPsdApi()
       // self.navigationController?.popViewController(animated: true)
    }
    
    //forgotPassword Api
         func forgotPsdApi(){
         let parameters:[String:Any] = ["email":txt_Email.text!]
          ForgotPsdDataResponse.AddUserData(api: "forgotPassword", parameters: parameters) {
             (data) in
             if data != nil {
                 let responseCode = data?.responseCode
                 let respocetext = data?.responseText
                 switch responseCode {
                 case 1:
                     print("Otp sent on your register email")
                     let responseText = data?.responseText ?? ""
                     ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                 case 0:
                     ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email")
                 default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email" )
                 }
             }
         }
     }
}

extension ForgotVC: UITextFieldDelegate{
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
            return true
        }
    }
