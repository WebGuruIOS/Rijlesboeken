//
//  ActivePackageDtlsVC.swift
//  Rijlesboeken
//
//  Created by Prince on 13/05/22.
//

import UIKit

class ActivePackageDtlsVC: UIViewController {

    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_RemainingBg: UIView!
    @IBOutlet weak var imgBgView: UIView!
 
    @IBOutlet weak var imgScooter: UIImageView!
    @IBOutlet weak var scooterBgView: UIView!
    
    @IBOutlet weak var vw_Previous: UIView!
    @IBOutlet weak var vw_Upcoming: UIView!
    @IBOutlet weak var vw_TypeBgView: UIView!
    
    @IBOutlet weak var lbl_VehicleType: UILabel!
    @IBOutlet weak var lbl_RemailLesson: UILabel!
    @IBOutlet weak var lbl_PurchDate: UILabel!
    @IBOutlet weak var lbl_TotalLessons: UILabel!
    @IBOutlet weak var lbl_RemainDays: UILabel!
    
    @IBOutlet weak var vw_BgNoProduct: UIView!
    @IBOutlet weak var lbl_NoProduct: UILabel!
    @IBOutlet weak var tbl_UpcomingTblView: UITableView!
    @IBOutlet weak var tblViewConstantHight: NSLayoutConstraint!
    @IBOutlet weak var constantHight: NSLayoutConstraint!
    
    var bookingArr = [bookingResponseData]()
    var trainerData:trainerinfoData?
    
    var driver_Img = String()
    var driver_Name = String()
    var dri_Contact = String()
    var dri_rating = Int()
    var vechile_Type = String()
    var ac_date = String()
    var ac_time = String()
    var ac_location = String()
    
    var remainLesson:Int = 0
    var vehicle_img:String = ""
    var vehicleType:String = ""
    var purchDate:String = ""
    var totalLesson:Int = 0
    var reaminValidity:Int = 0
    var type = "UPCOMING"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.vw_BgNoProduct.isHidden = true
        
        self.vw_Previous.roundCorners(corners: [.bottomRight, .topRight, .bottomLeft], radius: 25)
        self.vw_Upcoming.roundCorners(corners: [.bottomLeft, .topLeft,.bottomRight], radius: 25)
        Shadow.add(view: scooterBgView, color: .lightGray)
        Shadow.add(view: imgBgView, color: .lightGray)
        vw_BgView.layer.cornerRadius = 40.0

        vw_RemainingBg.layer.cornerRadius = 10.0
        scooterBgView.layer.cornerRadius = 10.0
        imgBgView.layer.cornerRadius = imgBgView.layer.frame.height / 2
        vw_TypeBgView.layer.cornerRadius = vw_TypeBgView.layer.frame.height / 2
        
        self.lbl_RemailLesson.text = String(remainLesson)
        self.lbl_VehicleType.text = vehicleType
        self.lbl_PurchDate.text = purchDate
        self.lbl_TotalLessons.text = String(totalLesson)
        self.lbl_RemainDays.text = String(reaminValidity) + " Days"
        self.imgScooter.sd_setImage(with:URL(string: vehicle_img))
        upcomLessoningApi()
    }
    
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_PreviousLesson(_ sender: Any) {
        self.vw_Previous.backgroundColor = UIColor.orange
        self.vw_Upcoming.backgroundColor = UIColor.white
        self.type = "COMPLETED"
        upcomLessoningApi()
        debugPrint("It is Privious Lesson buttom")
    }
    
    @IBAction func act_UpcomingLesson(_ sender: Any) {
        self.vw_Upcoming.backgroundColor = UIColor.orange
        self.vw_Previous.backgroundColor = UIColor.white
        self.type = "UPCOMING"
        upcomLessoningApi()
        debugPrint("It is Upcomin Lesson buttom")
    }
    
    
    func upcomLessoningApi(){
        let parameters:[String:Any] = ["date":"no","dateRange":"no","packageType":"0","status": self.type,"take": "ALL"]
        BookingDataResponse.AddUserData(api: "getBooking", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                let responseText = data?.responseText
                self.bookingArr = []
                if let data = data?.responseData{
                    for i in 0..<data.count {
                        self.bookingArr.append(data[i])
                    }
                }
                self.tbl_UpcomingTblView.reloadData()
                switch responceCode {
                case 1:
                    self.vw_BgNoProduct.isHidden = true
                   // ApiService.shared.showAlert(title:"", msg: responseText!)
                case 0:
                    self.vw_BgNoProduct.isHidden = false
                    self.lbl_NoProduct.text = data?.responseText!
                   // ApiService.shared.showAlert(title:"", msg: responseText!)
                default:
                    ApiService.shared.showAlert(title:"", msg: responseText!)
                }
            }
        }
    }
}

extension ActivePackageDtlsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  bookingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_UpcomingTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpcomingTVCell
        let dict1 = bookingArr[indexPath.row]
        let dict2 = dict1.trainerInfo
        let name = "\(dict2?.first_name ?? "")" + "\(dict2?.last_name ?? "")"
        cell.lbl_DriverName.text = name
        let imag = dict2?.image ?? ""
        cell.img_Driver.sd_setImage(with: URL(string: imag))
        cell.lbl_Contact.text = dict2?.phone
        cell.lbl_Date.text = dict1.date
        cell.lbl_Time.text = dict1.time
        cell.img_Rating.image = UIImage(named: "Star")
        cell.lbl_RatingNumber.text = String(dict2?.totalRating ?? 0)
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict1 = bookingArr[indexPath.row]
        let dict2 = dict1.trainerInfo
        let name = "\(dict2?.first_name ?? "")" + "\(dict2?.last_name ?? "")"
        self.driver_Img = dict2?.image ?? ""
        self.driver_Name = name
        self.dri_Contact = dict2?.phone ?? ""
        self.dri_rating = dict2?.totalRating ?? 0
        self.vechile_Type = String()
        self.ac_date = dict1.date ?? ""
        self.ac_time = dict1.time ?? ""
        self.ac_location = String()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"BookingDetails") as? BookingDetails
        vc?.driverImg = driver_Img
        vc?.driverName = driver_Name
        vc?.contact = dri_Contact
        vc?.rating = dri_rating
        vc?.vechileType = vechile_Type
        vc?.date = ac_date
        vc?.time = ac_time
        vc?.location = "HOME"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

