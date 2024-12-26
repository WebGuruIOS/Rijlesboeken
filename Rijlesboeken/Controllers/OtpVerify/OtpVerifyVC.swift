//
//  OtpVerifyVC.swift
//  Rijlesboeken
//
//  Created by Prince on 11/05/22.
//

import UIKit

class OtpVerifyVC: UIViewController {
    
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var vw_verifyBG: UIView!
    @IBOutlet weak var btn_ResendOtp: UIButton!
    @IBOutlet weak var txt_1: UITextField!
    @IBOutlet weak var txt_2: UITextField!
    @IBOutlet weak var txt_3: UITextField!
    @IBOutlet weak var txt_4: UITextField!
    
    @IBOutlet weak var lbl_Email: UILabel!
    
    
    var params:[String:Any] = [:]
    var otpvfy = Int()
    var otpValue = String()
    var dotpValues = String()
    var count = 60  // 60sec if you want
    var resendTimer = Timer()
    var emailOtp = String()
    var email = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.vw_verifyBG.roundCorners(corners: [.bottomLeft, .topRight,.bottomRight], radius: 25)
        self.lbl_Email.text = ("Please Enter the 4 digit code to " + email)
        
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        vw_BgView.layer.cornerRadius = 40.0
        view1.layer.cornerRadius = view1.layer.frame.height / 2
        view2.layer.cornerRadius = view2.layer.frame.height / 2
        view3.layer.cornerRadius = view3.layer.frame.height / 2
        view4.layer.cornerRadius = view4.layer.frame.height / 2
        
         txt_1.delegate = self
         txt_2.delegate = self
         txt_3.delegate = self
         txt_4.delegate = self
        print("Params Values:",params)
        print("GotOtp:",otpvfy)
       
    }
    
//    @objc func tapDone(sender: Any) {
//           self.view.endEditing(true)
//       }
    
    
    @IBAction func changeTextOtp(_ sender: UITextField) {
        let text = sender.text
        if text?.utf16.count ?? 0 >=  1{
            switch sender{
            case txt_1:
                txt_2.becomeFirstResponder()
            case txt_2:
                txt_3.becomeFirstResponder()
            case txt_3:
                txt_4.becomeFirstResponder()
            case txt_4:
                txt_4.resignFirstResponder()
            default:
                break
            }
        }
        else{
            txt_1.delete(sender)
            txt_2.delete(sender)
            txt_3.delete(sender)
            txt_4.delete(sender)
        }
    }
    
    @IBAction func act_Back(_ sender: Any) {
        resendTimer.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_ResendOtp(_ sender: Any) {
        self.txt_1.text = ""
        self.txt_2.text = ""
        self.txt_3.text = ""
        self.txt_4.text = ""
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        self.sendOtpApi()
    }
    
    @IBAction func act_Verify(_ sender: Any) {
        self.txt_1.resignFirstResponder()
        self.txt_2.resignFirstResponder()
        self.txt_3.resignFirstResponder()
        self.txt_4.resignFirstResponder()
      
    let aa = txt_1.text!
    let bb = txt_2.text!
    let cc = txt_3.text!
    let dd = txt_4.text!
        
        otpValues.append(aa)
        otpValues.append(bb)
        otpValues.append(cc)
        otpValues.append(dd)
        print("OtpValues",otpValues)
        print("OtpFromApi",otpvfy)
      
        if otpvfy == Int(otpValues){
            print("Otp Matched")
            let alertController = UIAlertController(title: "", message: "Otp verified sucessfully.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok" , style: .default){ (_ action) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddressDetailsVC") as? AddressDetailsVC
                vc!.parameters = self.params
                self.resendTimer.invalidate()
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            ok.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(ok)
            alertController.view.tintColor = .yellow
            self.present(alertController, animated: true, completion: nil)
        }else{
            print("Otp not matched")
            txt_1.text = ""
            txt_2.text = ""
            txt_3.text = ""
            txt_4.text = ""
            otpValues.removeAll()
            ApiService.shared.showAlert(title: "", msg: "Otp not matched")
        }
    }

    
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            btn_ResendOtp.setTitle(" 00 : \(count)", for: .normal)
            self.btn_ResendOtp.isUserInteractionEnabled = false
        }
        else {
            resendTimer.invalidate()
            self.btn_ResendOtp.isUserInteractionEnabled = true
            btn_ResendOtp.setTitle("Resend", for: .normal)
            print("call your api")
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    
    func sendOtpApi(){
       let parameters:[String:Any] = ["email" : emailOtp]
       OtpDataResponce.AddUserData(api: "sendOtp", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
               let responseText = data?.responseText
                if let data = data?.responseData{
                    self.otpvfy = 0
                   self.otpvfy = data.otp ?? 0
                   print("OptValue:",self.otpvfy)
                }
               switch responceCode {
               case 1:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
               case 0:
                   ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email")
               default:
                  ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email" )
               }
            }
        }
    }
}



extension OtpVerifyVC: UITextFieldDelegate{
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
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
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            return true
//        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.txt_1.resignFirstResponder()
            self.txt_2.resignFirstResponder()
            self.txt_3.resignFirstResponder()
            self.txt_4.resignFirstResponder()
            return true
        }
}

