//
//  AddressDetailsVC.swift
//  Rijlesboeken
//
//  Created by Prince on 11/05/22.
//

import UIKit

class AddressDetailsVC: UIViewController {
    
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_LocationBg: UIView!
    @IBOutlet weak var vw_ZipCodeBg: UIView!
    @IBOutlet weak var vw_HouseNoBg: UIView!
    @IBOutlet weak var vw_AddressBg: UIView!
    @IBOutlet weak var vw_TelephoneBg: UIView!
   
    @IBOutlet weak var vw_BgCompAccount: UIView!
    @IBOutlet weak var lbl_Location: UILabel!
    @IBOutlet weak var txt_ZipCode: UITextField!
    @IBOutlet weak var txt_HouseNo: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_PhoneNo: UITextField!
    @IBOutlet weak var btn_Agree: UIButton!
    
    @IBOutlet weak var vw_FullLocTblBg: UIView!
    @IBOutlet weak var vw_LocationTblBg: UIView!
    @IBOutlet weak var tbl_Location: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    var validInput:Bool = false
    var parameters:[String:Any] = [:]
    var locationId = Int()
    
    var termConStatus:Bool = false
    var locations = [locationResponseData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.vw_BgCompAccount.roundCorners(corners: [.bottomLeft,.bottomRight,.topRight], radius: 25)
        vw_BgView.layer.cornerRadius = 40.0
        vw_LocationBg.layer.cornerRadius = vw_LocationBg.layer.frame.height / 2
        vw_ZipCodeBg.layer.cornerRadius = vw_ZipCodeBg.layer.frame.height / 2
        vw_HouseNoBg.layer.cornerRadius = vw_HouseNoBg.layer.frame.height / 2
        vw_AddressBg.layer.cornerRadius = vw_AddressBg.layer.frame.height / 2
        vw_TelephoneBg.layer.cornerRadius = vw_TelephoneBg.layer.frame.height / 2
        
        self.vw_FullLocTblBg.isHidden = true
        self.vw_LocationTblBg.isHidden = true
        self.locationApi()
        
    }
    
    @objc func tapDone(sender: Any) {
           self.view.endEditing(true)
       }

    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_DropDown(_ sender: Any) {
        self.tbl_Location.reloadData()
        self.vw_FullLocTblBg.isHidden = false
        self.vw_LocationTblBg.isHidden = false
        
    }
    
    @IBAction func act_Agree(_ sender: Any) {
        if btn_Agree.isSelected{
            termConStatus = false
            btn_Agree.isSelected = false
        }else{
            termConStatus = true
            btn_Agree.isSelected = true
            self.btn_Agree.tintColor = .orange
            
        }
    }
    
    @IBAction func act_TermsConditions(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermConditionsVC") as? TermConditionsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Complete(_ sender: Any) {
        validInput = true
        self.txt_Email.resignFirstResponder()
        self.txt_PhoneNo.resignFirstResponder()
        self.txt_HouseNo.resignFirstResponder()
        self.txt_ZipCode.resignFirstResponder()
        if txt_ZipCode.text!.count == 0 {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter Zipcode", buttonLabel:"Ok")
        }
        if txt_ZipCode.text!.count <= 5 {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Zipcode should be 6 digit", buttonLabel:"Ok")
        }
        if txt_HouseNo.text == "" {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Please Your Enter House Number", buttonLabel:"Ok")
        }
        if txt_Email.text == "" {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Please Your Enter Address", buttonLabel:"Ok")
        }
        //mobile
        if isValidPhone(phone: txt_PhoneNo.text!){
//            self.alertDisplay(titleMsg:"", displayMessage:"Please Your Enter Phone Number", buttonLabel:"Ok")
        }else{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter valid Phone Number", buttonLabel:"Ok")
        }
        
        if termConStatus == true {
            let token = UserDefaults.standard.value(forKey: "Token")
            print("TockenValue:",token ?? "")
            
            let BeaValue = UserDefaults.standard.value(forKey: "Bearer")
            print("BeraeValue:",BeaValue ?? "")
            self.registerApi()
           
        }else{
            ApiService.shared.showAlert(title: "", msg: "Please read the Terms and Conditions")
        }
        
    }
    
     func registerApi() {
         RegisterDataResponce.AddUserData(api: "auth/register", parameters: parameters) {
             (data) in
             if data != nil{
                 let reponseCode = data?.responseCode
                 let responseText = data?.responseText
                 let responceData = data?.responseData
                 if let token = responceData?.token{
                     UserDefaults.standard.setValue(token, forKey: "Token")
                     UserDefaults.standard.synchronize()
                     print("Token:",token)
                 }
                 if let tokenType = responceData?.tokenType{
                     UserDefaults.standard.setValue(tokenType, forKey: "Bearer")
                     UserDefaults.standard.synchronize()
                     print("TkenType:",tokenType)
                 }
                 let userData = responceData?.user
                 if let id = userData?.user_id {
                     UserDefaults.standard.setValue(id, forKey: "user_id")
                     UserDefaults.standard.synchronize()
                     print("UserId:",id)
                 }
                 print("RegisterData:",responceData ?? "")
                 print("RegisterData:",responseText ?? "")
                 print("RegisterData:",reponseCode ?? "")
                 switch reponseCode {
                 case 1:
                     self.navigationController!.popToViewController(self, animated: true)
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                     self.hidesBottomBarWhenPushed = true
                     self.navigationController?.pushViewController(vc!, animated: true)
                     self.hidesBottomBarWhenPushed = true
                     self.updateAddressApi()
                    let vcCount = self.navigationController!.viewControllers.count
                     ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
                 case 0:
                     ApiService.shared.showAlert(title: "", msg: "Otp Not Mached")
                 default:
                    ApiService.shared.showAlert(title: "", msg: "Otp Not Mached" )
                 }
             }
         }
     }
    
    func updateAddressApi() {
        let parameters:[String:Any] = ["type":"home","location_id":"\(locationId)","zip_code":txt_ZipCode.text!,"address": txt_Email.text!,"house_number":txt_HouseNo.text!,"mobile": txt_PhoneNo.text!]
        print("ParamSValue:",parameters)
        AddressDataResponce.AddUserData(api: "updateAddress", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                let responseText = data?.responseText
               switch responceCode {
               case 1:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
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
    
    func locationApi(){
        let parameters:[String:Any] = ["":""]
        LocationDataResponse.AddUserData(api: "getLocation", parameters: parameters) {
            (data) in
            if data != nil {
                //let responceCode = data?.responseCode
                if let data = data?.responseData{
                    self.locations = []
                    for i in 0..<data.count{
                        self.locations.append(data[i])
                    }
                    
//                    self.vw_FullLocTblBg.isHidden = false
//                    self.vw_LocationTblBg.isHidden = false
//                    self.tbl_Location.reloadData()
//                    print("Location Value:", self.locations)
//                    print(responceCode ?? 0)
                }
            }
        }
    }
}

extension AddressDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_Location.dequeueReusableCell(withIdentifier: "LocCell", for: indexPath) as! LocationTableViewCell
        cell.selectionStyle = .none
        let dict = locations[indexPath.row]
        cell.lbl_Location.text = dict.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = locations[indexPath.row]
        self.lbl_Location.text = dict.name
        self.locationId = dict.id ?? 0
        self.vw_FullLocTblBg.isHidden = true
    }
}

