//
//  AddEditVC.swift
//  Rijlesboeken
//
//  Created by Prince on 02/05/22.
//

import UIKit

public protocol selectedAddress {
    func selectAddress(image: UIImage?)
}


class AddEditVC: UIViewController {
    
    @IBOutlet weak var vw_LocationTblBGView: UIView!
    @IBOutlet weak var vw_locationBgView: UIView!
    @IBOutlet weak var vw_ZipCodeBgView: UIView!
    @IBOutlet weak var vw_HouseNoBgView: UIView!
    @IBOutlet weak var vw_AdrsBgView: UIView!
    @IBOutlet weak var vw_PhoneNoBgView: UIView!
    
    @IBOutlet weak var vw_BgSave: UIView!
    @IBOutlet weak var lbl_Location: UILabel!
    @IBOutlet weak var txt_ZipCode: UITextField!
    @IBOutlet weak var txt_HouseNo: UITextField!
    @IBOutlet weak var txt_Address: UITextField!
    @IBOutlet weak var txt_PhoneNo: UITextField!
    
    @IBOutlet weak var btn_LocationTblView: UIButton!
    @IBOutlet weak var tbl_LocationtblView: UITableView!
    @IBOutlet weak var cons_TblHeight: NSLayoutConstraint!
    
    var locations = [locationResponseData]()
    var locationId:Int = 0
    var validInput:Bool = false
    var editLocation:String = ""
    var zip_code = Int()
    var houseNumber:String = ""
    var address:String = ""
    var phoneNum:String = ""
    var type = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadWorks()
    }

    @IBAction func act_Back(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func act_HideTableView(_ sender: Any) {
        self.vw_LocationTblBGView.isHidden = true
    }
    
    @IBAction func act_Save(_ sender: Any) {
        validInput = true
        
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
        if txt_Address.text == "" {
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Please Your Enter Address", buttonLabel:"Ok")
        }
        
        if isValidPhone(phone: txt_PhoneNo.text!){
        }else{
            validInput = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter valid Phone Number", buttonLabel:"Ok")
        }
        self.updateAddressApi(location: locationId)
    }
    
    @IBAction func act_LocationTbl(_ sender: Any) {
        self.vw_LocationTblBGView.isHidden = false
        self.tbl_LocationtblView.isHidden = false
        self.tbl_LocationtblView.reloadData()
        
    }
    
    func updateAddressApi(location: Int) {
        let parameters:[String:Any] = ["type":type,"location_id":"\(location)","zip_code":txt_ZipCode.text!,"address": txt_Address.text!,"house_number":txt_HouseNo.text!,"mobile": txt_PhoneNo.text!]
        print("ParamSValue:",parameters)
        AddressDataResponce.AddUserData(api: "updateAddress", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                let responseText = data?.responseText
               switch responceCode {
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
    
    func locationApi(){
        let parameters:[String:Any] = ["":""]
        LocationDataResponse.AddUserData(api: "getLocation", parameters: parameters) {
            (data) in
            if data != nil {
                if let data = data?.responseData{
                    self.locations = []
                    for i in 0..<data.count {
                        self.locations.append(data[i])
                    }
                    self.cons_TblHeight.constant = CGFloat(self.locations.count * 60)
                }
            }
        }
    }
    
    func viewDidLoadWorks(){
        self.tabBarController?.tabBar.isHidden = true
        self.vw_LocationTblBGView.isHidden = true
        self.tbl_LocationtblView.isHidden = true
        vw_BgSave.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        
        Shadow.add(view: vw_locationBgView, color: .lightGray)
        Shadow.add(view: vw_ZipCodeBgView, color: .lightGray)
        Shadow.add(view: vw_HouseNoBgView, color: .lightGray)
        Shadow.add(view: vw_AdrsBgView, color: .lightGray)
        Shadow.add(view: vw_PhoneNoBgView, color: .lightGray)
        self.vw_locationBgView.layer.cornerRadius = self.vw_locationBgView.layer.frame.height / 2
        self.vw_ZipCodeBgView.layer.cornerRadius = self.vw_ZipCodeBgView.layer.frame.height / 2
        self.vw_AdrsBgView.layer.cornerRadius = self.vw_AdrsBgView.layer.frame.height / 2
        self.vw_PhoneNoBgView.layer.cornerRadius = self.vw_PhoneNoBgView.layer.frame.height / 2
        self.vw_HouseNoBgView.layer.cornerRadius = self.vw_HouseNoBgView.layer.frame.height / 2
        
        self.lbl_Location.text = editLocation
        self.txt_ZipCode.text = String(zip_code)
        self.txt_HouseNo.text = houseNumber
        self.txt_Address.text = address
        self.txt_PhoneNo.text = phoneNum
        self.locationApi()
    }
}

extension AddEditVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_LocationtblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! LocationTblCell
        let dict = locations[indexPath.row]
        cell.lbl_Location.text = dict.name
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = locations[indexPath.row]
        self.lbl_Location.text = dict.name
        self.locationId = dict.id ?? 0
        self.vw_LocationTblBGView.isHidden = true
    }
}


