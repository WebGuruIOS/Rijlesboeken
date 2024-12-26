//
//  ContactUsVC.swift
//  Rijlesboeken
//
//  Created by Prince on 16/05/22.
//

import UIKit

class ContactUsVC: UIViewController {
    
    
    @IBOutlet weak var viewBg: UIView!{
        didSet{
            viewBg.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var vw_ContactInfoBgView: UIView!
    @IBOutlet weak var firstNameBgView: UIView!
    @IBOutlet weak var lastNameBgView: UIView!
    @IBOutlet weak var phoneNumberBgView: UIView!
    @IBOutlet weak var emailadrsBgView: UIView!
    @IBOutlet weak var subjectBgView: UIView!
    @IBOutlet weak var vw_MessageBgView: UIView!
    
    @IBOutlet weak var txt_FristName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_PhoneNumber: UITextField!
    @IBOutlet weak var txt_EmailAdrs: UITextField!
    @IBOutlet weak var txt_Subject: UITextField!
    @IBOutlet weak var txt_Message: UITextView!
    @IBOutlet weak var lbl_Gmail: UILabel!
    @IBOutlet weak var lbl_PhoneNumber: UILabel!
    @IBOutlet weak var lbl_ContactHours: UILabel!
    
    var contactData = [contectData]()
    var validInput:Bool = false
    var str_phone:String = ""
    var str_email:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        Shadow.add(view: vw_ContactInfoBgView, color: .lightGray)
        Shadow.add(view: firstNameBgView, color: .lightGray)
        Shadow.add(view: lastNameBgView, color: .lightGray)
        Shadow.add(view: phoneNumberBgView, color: .lightGray)
        Shadow.add(view: emailadrsBgView, color: .lightGray)
        Shadow.add(view: subjectBgView, color: .lightGray)
        Shadow.add(view: vw_MessageBgView, color: .lightGray)
        
        vw_ContactInfoBgView.layer.cornerRadius = 10.0
        firstNameBgView.layer.cornerRadius = firstNameBgView.layer.frame.height / 2
        
        lastNameBgView.layer.cornerRadius = lastNameBgView.layer.frame.height / 2
        phoneNumberBgView.layer.cornerRadius = phoneNumberBgView.layer.frame.height / 2
        emailadrsBgView.layer.cornerRadius = emailadrsBgView.layer.frame.height / 2
        subjectBgView.layer.cornerRadius = subjectBgView.layer.frame.height / 2
        vw_MessageBgView.layer.cornerRadius = 10.0
        self.contactInfoApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Gmail(_ sender: Any) {
        if let url: NSURL = NSURL(string: str_email) {
               UIApplication.shared.canOpenURL((url as NSURL) as URL)

            }
        
       
    }
    
    @IBAction func ace_Phone(_ sender: Any) {
        if let url = URL(string: str_phone),
               UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           
           }
    }
    
    @IBAction func act_Send(_ sender: Any) {
        
        validInput = true
       
         if txt_FristName.text == ""{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your first name", buttonLabel:"Ok")
         }else if txt_FristName.text!.count < 3 {
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter correct  first name", buttonLabel:"Ok")
         }
           
         if isValid(testStr:txt_FristName.text!){
             print("Valid firstName")
         }else{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your valid first name.", buttonLabel:"Ok")
         }
          
         if txt_LastName.text == ""{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your last name", buttonLabel:"Ok")
         }
         else if txt_LastName.text!.count < 3 {
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter correct last name", buttonLabel:"Ok")
         }
         
         if isValid(testStr:txt_LastName.text!){
             print("Valid lastName")
         }
         else{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your valid last name.", buttonLabel:"Ok")
         }
         
         if txt_PhoneNumber.text == ""{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your Phone number", buttonLabel:"Ok")
         }else if txt_PhoneNumber.text!.count < 10{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Phone number should be 10 digits", buttonLabel:"Ok")
         
          if txt_EmailAdrs.text == ""{
              validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter your email", buttonLabel:"Ok")
          }else if isValidEmail(email:txt_EmailAdrs.text!){
              print("Valid email")
         }else{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter valid email", buttonLabel:"Ok")
         }
    }
         if txt_Subject.text == ""{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter subject", buttonLabel:"Ok")
        }
         
         if txt_Message.text == ""{
             validInput = false
             self.alertDisplay(titleMsg:"", displayMessage:"Enter message", buttonLabel:"Ok")
        }
         if validInput{
             sendContactEnquiryApi()
           
         }
    }
    
    func contactInfoApi(){
        let parameters:[String:Any] = [:]
        ContectDataResponce.AddUserData(api: "getContactUs", parameters: parameters) { [self]
            (data) in
            if data != nil {
//                let responseCode = data?.responseCode
//                let responseText = data?.responseText
//                let respoceData = data?.responseData
                if let data = data?.responseData{
                    self.contactData = []
                    for i in 0..<data.count {
                        self.contactData.append(data[i])
                    }
                    debugPrint("Contact Data:",self.contactData)
                }
                    if let data1 = data?.responseData?[0] as contectData?{
                        self.lbl_Gmail.text = data1.email
                        str_phone = data1.email ?? ""
                        self.lbl_PhoneNumber.text = data1.phone
                        self.str_phone = data1.phone ?? ""
                        self.lbl_ContactHours.text = data1.contact_hour
                    }
              }
        }
    }
    
    func sendContactEnquiryApi(){
        let parameters:[String:Any] = ["firstName":txt_FristName.text!,"lastName":txt_LastName.text!,"phone":txt_PhoneNumber.text!,"email":txt_EmailAdrs.text!,"subject":txt_Subject.text!,"message":txt_Message.text!,"type":"contact"]
        EnquriryDataResponce.AddUserData(api: "sendContactEnquiry", parameters: parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                let respoceData = data?.responseData
                print(respoceData as Any)
                switch responseCode {
                case 1:
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                default:
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                }
            }
        }
    }
}

class Shadow {
    static func add(view:UIView,color:UIColor){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: 0 , height:4)
    }
}
