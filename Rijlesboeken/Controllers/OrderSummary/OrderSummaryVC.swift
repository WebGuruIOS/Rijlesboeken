//
//  OrderSummaryVC.swift
//  Rijlesboeken
//
//  Created by Prince on 16/05/22.
//

import UIKit

class OrderSummaryVC: UIViewController {
    
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var packagecarBgview: UIView!
    @IBOutlet weak var vw_OrderidBg: UIView!
    @IBOutlet weak var vwTypeBg: UIView!
    @IBOutlet weak var vw_TotalPriceBg: UIView!
    @IBOutlet weak var vw_OrderDtlsBg: UIView!
    
    @IBOutlet weak var img_Vehicle: UIImageView!

    @IBOutlet weak var lbl_OrderId: UILabel!
    @IBOutlet weak var lbl_TotalPrice: UILabel!
    @IBOutlet weak var lbl_Vehiclename: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_PaymentMode: UILabel!
    @IBOutlet weak var lbl_PaymentStatus: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Lesson: UILabel!
    
    var img = String()
    var vehi_Name = String()
    var vehi_Type = String()
    var vehi_ID = Int()
    var less = Int()
    var adrs = String()
    var price = String()
    var check_ID = String()
    var order_Id = String()
    var date = String()
    
    
   // var orderData = orderDataresponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Shadow.add(view: packagecarBgview, color: .lightGray)
        Shadow.add(view: vw_TotalPriceBg, color: .lightGray)
        Shadow.add(view: vw_OrderDtlsBg, color: .lightGray)
        Shadow.add(view: vw_OrderidBg, color: .lightGray)
        BgView.layer.cornerRadius = 40.0
        packagecarBgview.layer.cornerRadius = 10.0
        vw_OrderidBg.layer.cornerRadius = 10.0
        vw_TotalPriceBg.layer.cornerRadius = 10.0
        vwTypeBg.layer.cornerRadius = vwTypeBg.layer.frame.height / 2
        vw_OrderDtlsBg.layer.cornerRadius = 10.0
        orderSummaryApi()
        
        
        debugPrint("Address:",adrs)
        let image = img
        img_Vehicle.sd_setImage(with: URL(string: image))
        lbl_Vehiclename.text = vehi_Name
        lbl_Type.text = vehi_Type
        lbl_TotalPrice.text = "€" + price
        lbl_Lesson.text = String(less) + " Lessons"
        lbl_Address.text = adrs
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController!.popToViewController(self, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        hidesBottomBarWhenPushed = true
              self.navigationController?.pushViewController(vc!, animated: true)
        hidesBottomBarWhenPushed = true
        let vcCount = self.navigationController!.viewControllers.count
        print(vcCount)
    }
    @IBAction func act_ViewDetails(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyActivePackVC") as? MyActivePackVC
        
      //  vc?.packId = vehi_ID
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //paymentStatus/tr_JGxKYBkyaN
    
    
    func orderSummaryApi(){
       let parameters:[String:Any] = ["":""]
        OrderDataResponse.AddUserData(api: "paymentStatus/\(check_ID)", parameters: parameters) {
            (data) in
            if data != nil {
               // let responceCode = data?.responseCode
                //let responseText = data?.responseText
                if let data = data?.responseData{
                    
                    let tt = data.order_number
                    let ff = data.date
                    debugPrint("Order number:",tt ?? "")
                    debugPrint("Order Date:",ff ?? "")
                    self.lbl_Date.text = ff
                    self.lbl_OrderId.text = tt
                 
                }else{
                   print("No value")
                }
//               switch responceCode {
//               case 1:
//                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
//               case 0:
//                   ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email")
//               default:
//                  ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email" )
//               }
            }
        }
    }

}
