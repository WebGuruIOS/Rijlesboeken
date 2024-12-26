//
//  UpcomingBookingVC.swift
//  Rijlesboeken
//
//  Created by Prince on 10/05/22.
//

import UIKit

class UpcomingBookingVC: UIViewController {

    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var tbl_UpcomingTableView: UITableView!
    
    var bookingArr = [upcomingResponse]()
    var trainerArr = [trainerinfoData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        vw_BgView.layer.cornerRadius = 40.0
        upcomingBookingApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController!.popToViewController(self, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        hidesBottomBarWhenPushed = true
              self.navigationController?.pushViewController(vc!, animated: true)
        hidesBottomBarWhenPushed = true
        let vcCount = self.navigationController!.viewControllers.count
        print(vcCount)
       // validationStatus = false
    }
    
    func upcomingBookingApi() {
        let parameters:[String:Any] = ["status":"Upcoming","packageType":"0","date":"no","dateRange":"no", "take":"All"]
        UpcomingDataResponse.AddUserData(api:"getBooking", parameters:parameters) {
            (data) in
            if data != nil {
                
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                if let data1 = data?.responseData{
                    for i in 0..<data1.count{
                        self.bookingArr.append(data1[i])
                    }
            }
                debugPrint(responseCode ?? 0)
                debugPrint(responseText ?? "")
                debugPrint("responseData:", self.bookingArr)
                self.tbl_UpcomingTableView.reloadData()
            }
        }
    }

}

extension UpcomingBookingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   bookingArr.count  // trainerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_UpcomingTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpcomingTVCell
        
        let dict = bookingArr[indexPath.row]
        let dict2 = dict.trainerInfo
        debugPrint("Trainer INfO:",dict2 )
        let name = "\(dict2.first_name ?? "")" + "\(dict2.last_name ?? "")"
        let imag = dict2.image ?? ""
        cell.img_Driver.sd_setImage(with: URL(string: imag))
        cell.lbl_DriverName.text = name
        cell.lbl_Date.text = dict.date
        cell.lbl_Time.text = dict.time
        cell.lbl_RatingNumber.text = String(dict2.totalRating ?? 0)
        cell.lbl_Contact.text = dict2.phone
        cell.selectionStyle = .none
        return cell
        
    }
}
