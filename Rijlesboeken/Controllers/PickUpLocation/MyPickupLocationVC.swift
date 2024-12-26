//
//  MyPickupLocationVC.swift
//  Rijlesboeken
//
//  Created by Prince on 02/05/22.
//

import UIKit

protocol DataPass{
    func dataPassing(object:[String:String])
}

class MyPickupLocationVC: UIViewController {
    
    var delegate:DataPass!

    @IBOutlet weak var vw_BgView: UIView!
    
    @IBOutlet weak var vw_HomeAdrsBgView: UIView!
    @IBOutlet weak var vw_WorkAdrsBgView: UIView!
    @IBOutlet weak var vw_workBgView: UIView!
    @IBOutlet weak var vw_HomeBgView: UIView!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_workEdit: UIButton!
   
    //Add Home address
    @IBOutlet weak var vw_AddHomeadrsBgView: UIView!
    @IBOutlet weak var lbl_ContactNumber: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var btn_AddHomeAdrs: UIButton!
    @IBOutlet weak var btn_HomeAdrs: UIButton!
    
    // Add Work Address
    @IBOutlet weak var vw_AddWorkAdrs: UIView!
    @IBOutlet weak var btn_AddWorkAdrs: UIButton!
    @IBOutlet weak var lbl_WorkContactNo: UILabel!
    @IBOutlet weak var lbl_WorkAddress: UILabel!
    @IBOutlet weak var btn_WorkAdrs: UIButton!
    
    var pickAddress = [addressData]()
    var homeId:Int = 0
    var typehome:String = ""
    var zip_Code:Int = 0
    var address:String = ""
    var locId:Int = 0
    var locName:String = ""
    var houseNum:String = ""
    var contact:String = ""
    
    var typework:String = ""
    var workId:Int = 0
    var workzip_Code = Int()
    var workaddress:String = ""
    var worklocId:Int = 0
    var worklocName:String = ""
    var workhouseNum:String = ""
    var workcontact:String = ""
    var idHomeWork:String = ""
    var dataCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadWorks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickLocationApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_WorkAddressEdit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddEditVC") as? AddEditVC
        vc?.houseNumber = workhouseNum
        vc?.zip_code = workzip_Code
        vc?.editLocation = worklocName
        vc?.address = workaddress
        vc?.phoneNum = workcontact
        vc?.type = typework
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func act_HomeAdrsEdit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddEditVC") as? AddEditVC
        vc?.houseNumber = houseNum
        vc?.zip_code = zip_Code
        vc?.editLocation = locName
        vc?.address = address
        vc?.phoneNum = contact
        vc?.type = typehome
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_AddHomeAdrs(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddEditVC") as? AddEditVC
        vc?.type = "Home"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_AddWorkAdrs(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddEditVC") as? AddEditVC
        vc?.type = "Work"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_HomeChangeAdrs(_ sender: Any) {
      //  It is Home change Address
        let dict:[String:String] = ["locationId":"\(locId)","HomeId":"\(homeId)","locatioName":locName, "contactNo":contact,"zipCode":"\(zip_Code)","address":address,"houseNo":houseNum,"adrsType":typehome]
        delegate.dataPassing(object: dict)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_WorkChnageAdrs(_ sender: Any) {
      //  It is Work change Address
        let dict:[String:String] = ["locationId":"\(worklocId)","HomeId":"\(workId)","locatioName":worklocName, "contactNo":workcontact,"zipCode":"\(workzip_Code)","address":workaddress,"houseNo":workhouseNum,"adrsType":typework]
        delegate.dataPassing(object: dict)
        self.navigationController?.popViewController(animated: true)
    }
    
    func pickLocationApi() {
        let parameters:[String:Any] = [:]
        PickDataResponse.AddUserData(api: "getAddress", parameters:parameters) { [self]
            (data) in
            if data != nil {
                let responseCode = data?.status
                //let responseText = data?.msg
                if let data1 = data?.payload{
                    self.dataCount = data1.count
                    if addressStatus == "1"{
                        self.btn_HomeAdrs.isHidden = false
                        self.btn_WorkAdrs.isHidden = false
                    }else{
                        self.btn_HomeAdrs.isHidden = true
                        self.btn_WorkAdrs.isHidden = true
                    }
                    self.pickAddress = []
                    for i in 0..<data1.count {
                        self.pickAddress.append(data1[i])
                    }
                }
                vw_AddHomeadrsBgView.isHidden = false
                if responseCode != 0 {
                    if data != nil {
                        if let data2 = data?.payload?[0] as addressData?{
                            let addrs = "\(data2.address ?? "")" + " \(data2.zip_code ?? 0)"
                            self.lbl_Address.text = addrs
                            self.lbl_ContactNumber.text = data2.mobile
                            self.homeId = data2.id ?? 0
                            self.locId = data2.location_id ?? 0
                            self.locName = data2.locationName ?? ""
                            self.zip_Code = data2.zip_code ?? 0
                            self.address = data2.address ?? ""
                            self.contact = data2.mobile ?? ""
                            self.houseNum = data2.house_number ?? ""
                            self.typehome = data2.type ?? ""
                            if let text = lbl_ContactNumber.text, !text.isEmpty {
                                vw_AddHomeadrsBgView.isHidden = true
                                btn_Edit.isHidden = false
                            } else {
                                vw_AddHomeadrsBgView.isHidden = false
                                btn_Edit.isHidden = true
                            }
                        }
                    }
                if dataCount == 2 {
                        debugPrint("All Address Data",self.dataCount)
                       if let data2 = data?.payload?[1] as addressData?{
                           self.pickAddress.removeAll()
                           let addrs = "\(data2.address ?? "")" + " \(data2.zip_code ?? 0)"
                           self.lbl_WorkAddress.text = addrs
                           self.lbl_WorkContactNo.text = data2.mobile
                           self.workId = data2.id ?? 0
                           self.worklocId = data2.location_id ?? 0
                           self.worklocName = data2.locationName ?? ""
                           self.workzip_Code = data2.zip_code ?? 0
                           self.workaddress = data2.address ?? ""
                           self.workcontact = data2.mobile ?? ""
                           self.workhouseNum = data2.house_number ?? ""
                           self.typework = data2.type ?? ""
                           if let text = lbl_WorkContactNo.text, !text.isEmpty {
                               vw_AddWorkAdrs.isHidden = true
                               btn_workEdit.isHidden = false
                           } else {
                               vw_AddWorkAdrs.isHidden = false
                               btn_workEdit.isHidden = true
                           }
                       }
                    }
                }
            }
        }
    }
    
    func viewDidLoadWorks(){
        debugPrint(addressStatus)
        self.tabBarController?.tabBar.isHidden = true
        Shadow.add(view: vw_HomeAdrsBgView, color: .lightGray)
        Shadow.add(view: vw_WorkAdrsBgView, color: .lightGray)
        vw_BgView.layer.cornerRadius = 40.0
        vw_HomeAdrsBgView.layer.cornerRadius = 10.0
        vw_WorkAdrsBgView.layer.cornerRadius = 10.0
        vw_workBgView.layer.cornerRadius = vw_workBgView.layer.frame.height / 2
        vw_HomeBgView.layer.cornerRadius = vw_HomeBgView.layer.frame.height / 2
        btn_Edit.layer.cornerRadius = btn_Edit.layer.frame.height / 2
        btn_workEdit.layer.cornerRadius = btn_workEdit.layer.frame.height / 2
        self.btn_AddHomeAdrs.layer.cornerRadius = self.btn_AddHomeAdrs.layer.frame.height / 2
        self.btn_AddWorkAdrs.layer.cornerRadius = self.btn_AddWorkAdrs.layer.frame.height / 2
        
        if let text = lbl_WorkAddress.text, !text.isEmpty {
            self.vw_AddWorkAdrs.isHidden = true
            btn_workEdit.isHidden = false
        }else{
            self.vw_AddWorkAdrs.isHidden = false
            btn_workEdit.isHidden = true
        }
        self.btn_HomeAdrs.isHidden = true
        self.btn_WorkAdrs.isHidden = true
    }
}


