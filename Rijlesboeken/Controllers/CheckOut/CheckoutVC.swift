//
//  CheckoutVC.swift
//  Rijlesboeken
//
//  Created by Prince on 30/04/22.
//

import UIKit

class CheckoutVC: UIViewController, DataPass {

    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_AdrsBgView: UIView!
    
    @IBOutlet weak var vw_AddressBgView: UIView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Gmail: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var vw_PackageCarBgView: UIView!
    @IBOutlet weak var img_vehicle: UIImageView!
    @IBOutlet weak var lbl_vehicleName: UILabel!
    @IBOutlet weak var lbl_Lesson: UILabel!
    @IBOutlet weak var vw_AutoBgView: UIView!
    @IBOutlet weak var lbl_Auto: UILabel!
    @IBOutlet weak var vw_PaymentBgView: UIView!
    @IBOutlet weak var lbl_PaymentMode: UILabel!
    @IBOutlet weak var vw_TotelPriceBgView: UIView!
    @IBOutlet weak var lbl_TotelPrice: UILabel!
    
    @IBOutlet weak var vw_ProceedBG: UIView!
    @IBOutlet weak var vw_ChangeAdrsBG: UIView!
    @IBOutlet weak var cons_ChangeAdrsHeight: NSLayoutConstraint!
    
    var vehicleImage = String()
    var vehicleName:String = ""
    var vehicleType = ""
    var price:String = ""
    var lessons = Int()
    var vehicleId = Int()
    var homeWork:String = "1"
    var chek_Id = String()
    var payUrl = String()
    var address = "" //String()
    var ammount = String()
    
    var pickAddress = [addressData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickLocationApi()
        vw_ChangeAdrsBG.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        
        vw_ProceedBG.roundCorners(corners: [.bottomLeft,.topRight,.bottomRight], radius: 25)
        vw_BgView.layer.cornerRadius = 40.0
        vw_AddressBgView.layer.cornerRadius = 10.0
        vw_PackageCarBgView.layer.cornerRadius = 10.0
        vw_AutoBgView.layer.cornerRadius = vw_AutoBgView.layer.frame.height / 2
        vw_PaymentBgView.layer.cornerRadius = 10.0
        vw_TotelPriceBgView.layer.cornerRadius = 10.0
        vw_AdrsBgView.layer.cornerRadius = 10.0
        
        let img = vehicleImage
        self.img_vehicle.sd_setImage(with: URL(string: img))
        lbl_Name.text = vehicleName
        lbl_Auto.text = vehicleType
        lbl_Lesson.text = String(lessons) + " Lessons"
        lbl_TotelPrice.text = String(price)
       // img_vehicle = vehicleImage
        debugPrint("Vehicle id:",vehicleId)
       // self.vw_AdrsBgView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            profilesApi()
            
//        if address != ""{
//            cons_ChangeAdrsHeight.constant = 0
//        }else{
//            cons_ChangeAdrsHeight.constant = 250
//        }
    }
        
//    func dataPassing(name: String, email: String, roll: String) {
//        print(name)
//        print(email)
//        print(roll)
//    }
    
    func dataPassing(object: [String : String]) {
     //   let xyz = object["locationId"]
      //  let ss = object["HomeId"]
      //  let dd = object["locatioName"]
      //  let ff = object["houseNo"]
      //  let aa = object["zipCode"]
       // let gg = object["address"]
      //  let rr = object["adrsType"]
       // let tt = object["contactNo"]
        
        
        /*
         ["locationId":"\(locId)","HomeId":"\(homeId)","locatioName":locName, "houseNo":houseNum,"zipCode":"\(zip_Code)","address":address,"houseNo":houseNum,"adrsType":typehome]
         
         */
        let addrs = "\(object["houseNo"] ?? "")" + " \(object["address"] ?? "") " + "\(object["zipCode"] ?? "")"
        self.lbl_Address.text = addrs
        address = addrs
    }
    
    @IBAction func act_ViewDetails(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier:"PackageCarVC") as? PackageCarVC
//        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func act_ChangeAddress(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"MyPickupLocationVC") as? MyPickupLocationVC
        addressStatus = "1"
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Bcak(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_ProceedToPay(_ sender: Any) {
        self.purchasePackageApi()
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
               // let userId = user?.user_id
               // print("UserId:",userId ?? 0)
                let name = "\(user?.first_name ?? "")" + " \(user?.last_name ?? "")"
                UserDefaults.standard.set(name, forKey: "name")
                print("User Name:",name)
                self.lbl_Name.text = name
                self.lbl_Gmail.text = user?.email
                self.lbl_Mobile.text = user?.phone
                debugPrint(responseCode ?? 0)
                debugPrint(responseText ?? "")
            }
            
        }
    }
    
    func pickLocationApi() {
        let parameters:[String:Any] = [:]
        PickDataResponse.AddUserData(api: "getAddress", parameters:parameters) { [self]
            (data) in
            if data != nil {
                let responseCode = data?.status
                let responseText = data?.msg
                if let data1 = data?.payload{
                    self.pickAddress = []
                    for i in 0..<data1.count {
                        self.pickAddress.append(data1[i])
                    }
                }
                if responseCode != 0 {
                    if data != nil {
                        if let data2 = data?.payload?[0] as addressData?{
                            let addrs = "\(data2.address ?? "")" + " \(data2.zip_code ?? 0)"
                            self.lbl_Address.text = addrs
                            self.address = addrs
                        }
                    }
                }
                debugPrint(responseCode ?? 0)
                debugPrint(responseText ?? "")
            }
        }
    }
    
  
    func purchasePackageApi() {
        let parameters:[String:Any] = ["package_id":vehicleId]
        CheckOutDataResponse.AddUserData(api: "purchasePackage", parameters:parameters) { [self]
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                if let data1 = data?.responseData{
                    chek_Id = data1.id ?? ""
                    let ff = data1._links
                    let tt = ff?.checkout
                     payUrl = tt?.href ?? ""
                    let orderId = tt?.href
                    let rr = data1.amount
                    ammount = rr?.value ?? ""
                    debugPrint("URL For Payment:", payUrl)
                    debugPrint("Checkout Id:",data1.id ?? 0)
                    debugPrint("Checkout value:",orderId ?? "")
                }
                switch responseCode {
                case 1:
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"PaymentVC") as? PaymentVC
                    vc?.vehicle_Image = vehicleImage
                    vc?.vehicle_Name = vehicleName
                    vc?.vehicle_Type = vehicleType
                    vc?.price = price
                    vc?.lessons = lessons
                    vc?.vehicleId = vehicleId
                    vc?.chekId = chek_Id
                    vc?.paymentUrl = payUrl
                    vc?.orderAdrs = address
                    vc?.order_Price = ammount
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
//                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                    
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something went wrong")
                }
            }
        }
    }
    
}
