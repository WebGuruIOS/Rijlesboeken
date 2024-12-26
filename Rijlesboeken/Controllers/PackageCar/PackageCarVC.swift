//
//  PackageCarVC.swift
//  Rijlesboeken
//
//  Created by Prince on 28/04/22.
//

import UIKit

class PackageCarVC: UIViewController {
    @IBOutlet weak var vw_FullBgView: UIView!{
        didSet{
            vw_FullBgView.layer.cornerRadius = 40.0
        }
    }
    @IBOutlet weak var lbl_packageType: UILabel!
    @IBOutlet weak var vw_DetailsBgView: UIView!
    @IBOutlet weak var lbl_Vehicle: UILabel!
    @IBOutlet weak var lbl_SpecialPrice: UILabel!
    @IBOutlet weak var vw_AutoBg: UIView!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_Lesson: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var img_Vehicle: UIImageView!
    @IBOutlet weak var vw_BuyBG: UIView!
    
    //var lespakkettenArr = [packageDataResponse]()
    var packageArr = [responseData]()
    var specialPrice:String = ""
    var packId = Int()
    var vehicle_Image = String()
    var vehicle_Name:String = ""
    var vehicle_Type = ""
    var lesson = Int()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        vw_BuyBG.roundCorners(corners: [.bottomLeft,.topRight,.topLeft], radius: 25)
        Shadow.add(view: vw_DetailsBgView, color: .lightGray)
        self.vw_DetailsBgView.layer.cornerRadius = 10.0
        self.vw_AutoBg.layer.cornerRadius = self.vw_AutoBg.layer.frame.height / 2
        self.packageDtlsApi()
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.packageDtlsApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func act_BuyNow(_ sender: Any) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as? CheckoutVC
            vc?.vehicleImage = vehicle_Image
            vc?.vehicleName = vehicle_Name
            vc?.vehicleType = vehicle_Type
            vc?.price = specialPrice
            vc?.lessons = lesson
            vc?.vehicleId = packId
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.logInDtls1()
        }
        
    }
  
    
    
    func logInDtls1(){
        let alertController = UIAlertController(title: "Login Require", message: "You have not login yet. Please login.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default){ (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            let navVC = UINavigationController(rootViewController: updateProfileVC)
//            navVC.modalPresentationStyle = .fullScreen
//            self.present(navVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    
    func forSearch(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerListVC") as? TrainerListVC
        self.navigationController?.pushViewController(vc!, animated: true)
            debugPrint("This is search")
    }
    
    
   func packageDtlsApi(){
        let parameters:[String:Any] = ["":""]
    packageDataValue.AddUserData(api: "getPackageDetail/\(packId)", parameters: parameters){ [self]
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responsetext = data?.responseText
                //let responseData = data?.responseData
                if let data = data?.responseData?[0] as responseData? {
                    self.lbl_packageType.text = data.name
                    let img = data.image
                    self.img_Vehicle.sd_setImage(with: URL(string: img ?? ""))
                    self.lbl_Vehicle.text = data.package_type
                    self.lbl_Lesson.text = String(data.no_of_lesson ?? 0) + " Lession"
                    self.lbl_Description.text = data.description
                    self.lbl_Price.text = "€" + String(data.price ?? 0)
                    self.lbl_SpecialPrice.text = "€" + String(data.special ?? 0)
                    self.specialPrice = "€" + String(data.special ?? 0)
                    
                    self.packId = data.id ?? 0
                    self.vehicle_Image = data.image ?? ""
                    self.vehicle_Name = data.name ?? ""
                    self.vehicle_Type = data.package_type ?? ""
                    self.lesson = data.no_of_lesson ?? 0
                    
                    
                    
//                    self.vehicleImage = String()
//                    self.vehicleName:String = ""
//                    self.vehicleType = ""
//                    self.price:Int = 0
//                    self.lessons = Int()
//                    self.vehicleId = 0

                    
                    
                    
                    
                    debugPrint("PackageArrDatas",packageArr )
                }
               
              
               // ApiService.shared.showAlert(title: "", msg: "\(responsetext ?? "")")
                debugPrint(responseCode ?? 0)
                debugPrint(responsetext ?? 0)
                
             if let data = data?.responseData?[0] as responseData? {
                    
                    if specialPrice.isEmpty {
                        lbl_Price.isHidden = false
                        lbl_SpecialPrice.text = ""
                        lbl_SpecialPrice.isHidden = true
                        let str_price =  String(data.price ?? 0)
                        let attributeString = NSMutableAttributedString(string: str_price)
                        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
                        attributeString.removeAttribute(NSAttributedString.Key.strikethroughColor, range: NSMakeRange(0, attributeString.length))
                        lbl_Price.attributedText = attributeString
                        lbl_Price.textColor = UIColor.black
                        
                    }else{
                        
                        lbl_Price.isHidden = false
                        lbl_SpecialPrice.isHidden = false
                        
                        let str_price = "€" + String(data.price ?? 0)
                        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string:str_price)
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                        lbl_Price.attributedText = attributeString
                        lbl_Price.textColor = UIColor.lightGray
                        lbl_SpecialPrice.textColor = UIColor.black
                        //lbl_SpecialPrice.text = "€" + "\(special)"
                    }
                }

            }
        }
    }
}
