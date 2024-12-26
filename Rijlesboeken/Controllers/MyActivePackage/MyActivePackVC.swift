//
//  MyActivePackVC.swift
//  Rijlesboeken
//
//  Created by Prince on 02/05/22.

import UIKit

class MyActivePackVC: UIViewController {
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var tbl_PackageTblView: UITableView!
    var activePackArr = [activepackData]()
    
    var remLesson:Int = 0
    var vehi_img:String = ""
    var vehi_Type:String = ""
    var purchaseDate:String = ""
    var totlLesson:Int = 0
    var reaminVal:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_PackageTblView.delegate = self
        self.tbl_PackageTblView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        vw_BgView.layer.cornerRadius = 40.0
        self.activepackageApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

     func activepackageApi() {
       let parameters:[String:Any] = ["":""]
        ActivePackResponse.AddUserData(api: "getActivePackage/ACTIVE", parameters: parameters) { [self]
           (data) in
           if data != nil {
            let responseCode = data?.responseCode
            let responseText = data?.responseText
//            let responseData = data?.responseData
               if let data = data?.responseData{
              self.activePackArr = []
                   for i in 0..<data.count {
                       self.activePackArr.append(data[i])
                   }
               }
               switch responseCode {
               case 0:
                   ApiService.shared.showAlert(title: "", msg: responseText!)
//               case 1:
//                   ApiService.shared.showAlert(title: "", msg: responseText!)
               default :
                   debugPrint("Sucess")
                   //ApiService.shared.showAlert(title: "", msg: responseText!)
               }
                             
            self.tbl_PackageTblView.reloadData()
       }
        
     }
  }
}

extension MyActivePackVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  activePackArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_PackageTblView.dequeueReusableCell(withIdentifier: "cell") as! MyActivePackCell
        let dict1 = activePackArr[indexPath.row]
        cell.lbl_Package.text = dict1.name
        cell.lbl_Auto.text = dict1.package_type
        cell.lbl_Lessons.text = String(dict1.remaining_lesson ?? 0) + " Lessons"
        cell.lbl_remainLesson.text = String(dict1.remaining_lesson ?? 0)
        cell.lbl_validityDays.text = String(dict1.valid_upto ?? 0) + " Days"
        let img = dict1.image ?? ""
        cell.img_Vehicle.sd_setImage(with: URL(string:img), placeholderImage: UIImage(named: "Car1"))
//        cell.btn_ViewDtls.addTarget(self, action: #selector(clickedOnViewDtls(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict1 = activePackArr[indexPath.row]
        self.remLesson = dict1.remaining_lesson ?? 0
        self.vehi_img = dict1.image ?? ""
        self.vehi_Type = dict1.package_type ?? ""
        self.purchaseDate = dict1.purchase_date ?? ""
        self.totlLesson = dict1.total_lesson ?? 0
        self.reaminVal = dict1.valid_upto ?? 0
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ActivePackageDtlsVC") as? ActivePackageDtlsVC
        vc?.remainLesson = remLesson
        vc?.vehicle_img = vehi_img
        vc?.vehicleType = vehi_Type
        vc?.purchDate = purchaseDate
        vc?.totalLesson = totlLesson
        vc?.reaminValidity = reaminVal

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
//    @objc func clickedOnViewDtls(sender:UIButton){
//        _ = sender.tag
//        //let indexPath = IndexPath(row:tag, section:0)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ActivePackageDtlsVC") as? ActivePackageDtlsVC
//        vc?.remainLesson = remLesson
//        vc?.vehicle_img = vehi_img
//        vc?.vehicleType = vehi_Type
//        vc?.purchDate = purchaseDate
//        vc?.totalLesson = totlLesson
//        vc?.reaminValidity = reaminVal
//        self.navigationController?.pushViewController(vc!, animated: true)
//  }
}
