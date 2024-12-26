//
//  MyInvoiceVC.swift
//  Rijlesboeken
//
//  Created by Prince on 10/05/22.
//

import UIKit

class MyInvoiceVC: UIViewController {

    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var tbl_InvoiceTableView: UITableView!
    var arr_invoice = [invoiceResponseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        vw_BgView.layer.cornerRadius = 40.0
        self.invoiceApi()
    }
    

    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func invoiceApi() {
      let parameters:[String:Any] = ["":""]
        InvoiceDataResponce.AddUserData(api: "getActivePackage/ACTIVE", parameters: parameters) {
          (data) in
          if data != nil {
           let responseCode = data?.responseCode
           let responseText = data?.responseText
           let responseData = data?.responseData
              if let data = data?.responseData{
               self.arr_invoice = []
                  for i in 0..<data.count {
                      self.arr_invoice.append(data[i])
                  }
              }
              debugPrint("PackageArr:", self.arr_invoice)
              debugPrint(responseCode ?? 0)
           debugPrint(responseText ?? 0)
           debugPrint(responseData ?? 0)
          self.tbl_InvoiceTableView.reloadData()
      }
    }
 }
}

extension MyInvoiceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_invoice.count //invoiceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_InvoiceTableView.dequeueReusableCell(withIdentifier: "cell") as! MyInvoiceTVCell
       // let dict = invoiceArr[indexPath.row]
        let dict = arr_invoice[indexPath.row]
        cell.lbl_Vehiclename.text = dict.name
        let imag = dict.image ?? ""
        cell.img.sd_setImage(with: URL(string: imag), placeholderImage: UIImage(named: "Car1"))
        cell.lbl_Price.text = "€ " + String(dict.offer_price ?? 0)
        cell.lbl_PurchaseDate.text = "Purchase Date"
        cell.lbl_Date.text = dict.purchase_date
        cell.lbl_Active.text = "Active"
        cell.lbl_Type.text = dict.package_type
        cell.lbl_Lesson.text = String(dict.remaining_lesson ?? 0) + " Lessons"
        return cell
    }
    
    //
}
