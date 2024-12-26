//
//  HomeViewController.swift
//  Rijlesboeken
//
//  Created by Prince on 21/04/22.
//

import UIKit
//import Alamofire


class HomeViewController: UIViewController {
    
    @IBOutlet weak var vw_LoginBg: UIView!
    @IBOutlet weak var vw_LogingSBg: UIView!
    @IBOutlet weak var lbl_HowWorkIt: UILabel!
    
    //BannerView
    @IBOutlet weak var vw_SearchView: UIView!
    @IBOutlet weak var vw_BannerBgView: UIView!
    @IBOutlet weak var bannercollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
   
    //Booking
    @IBOutlet weak var vw_BookingFullBg: UIView!
    @IBOutlet weak var cons_BookingHeight: NSLayoutConstraint!
    @IBOutlet weak var coll_BookingCollectionView: UICollectionView!
    @IBOutlet weak var vw_BookingBgView: UIView!
    @IBOutlet weak var vw_BookingCellBgView: UIView!
    
    //Lespakketten
    @IBOutlet weak var vw_LespakkaFullBgView: UIView!
    @IBOutlet weak var cons_LespakkHeight: NSLayoutConstraint!
    @IBOutlet weak var vw_LespakkaBgView: UIView!
    @IBOutlet weak var vw_CarBikeimgBgView: UIView!
    @IBOutlet weak var coll_imgCollectionView: UICollectionView!
    @IBOutlet weak var vw_plaastBgView: UIView!
    @IBOutlet weak var vw_HowisworkBgView: UIView!

    //Location
    @IBOutlet weak var vw_LocationFullBg: UIView!
    @IBOutlet weak var cons_LocationHeight: NSLayoutConstraint!
    @IBOutlet weak var coll_LocationCollectionView: UICollectionView!
    
    var userId = UserDefaults.standard.value(forKey: "user_id")
    
    var bannerDataArr = [bannerImagesData]()
    var bookingArr = [bookingResponseData]()
    var info:userinfoData?
    var trainerData:trainerinfoData?
    
    var lespakkettenArr = [packageDataResponse]()
    var locationArr = [locationResponseData]()
    var timer = Timer()
    var counter = 0
    var validationStatus:Bool?
    var packType:Int = 0
    
    // For Booking Details
    var driver_Img = String()
    var driver_Name = String()
    var driver_Phone = String()
    var dri_rating = Int()
    var vechile_Type = String()
    var ac_date = String()
    var ac_time = String()
    var ac_location = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Shadow.add(view: vw_plaastBgView, color: .lightGray)
        self.vw_SearchView.layer.cornerRadius = 10.0
        self.vw_CarBikeimgBgView.layer.cornerRadius = 10.0
        self.vw_BookingBgView.layer.cornerRadius = 10.0
        self.vw_BookingCellBgView.layer.cornerRadius = 10.0
        self.vw_LespakkaBgView.layer.cornerRadius = 10.0
        self.vw_CarBikeimgBgView.layer.cornerRadius = 10.0
        self.vw_plaastBgView.layer.cornerRadius = 10.0
        self.vw_HowisworkBgView.layer.cornerRadius = 10.0
        
//        if self.validationStatus == true {
//            self.vw_LoginBg.isHidden = false
//            self.vw_LogingSBg.isHidden = false
//        }else{
//            self.vw_LoginBg.isHidden = true
//            self.vw_LogingSBg.isHidden = true
//        }
        self.bannerApi()
        self.packageApi()
        self.locationApi()
        self.howWorkItApi()
        
      //  self.cons_BookingHeight.constant = 0
        
        debugPrint("Valueof bannerArray:",bannerDataArr.count)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            self.bookingApi()
//            self.vw_BookingFullBg.isHidden = false
//           self.cons_BookingHeight.constant = 175
        }else{
            self.vw_BookingFullBg.isHidden = false
            self.cons_BookingHeight.constant = 0
            
//            if self.bookingArr.count != 0 {
//                self.vw_BookingFullBg.isHidden = false
//                self.cons_BookingHeight.constant = 175
//            }else{
//                self.vw_BookingFullBg.isHidden = true
//                self.cons_BookingHeight.constant = 0
//            }
        }
        
    }
  
    @objc func changeImage() {
     
        if bannerDataArr.count != 0{
            if counter < bannerDataArr.count {
                let index = IndexPath.init(item: counter, section: 0)
                self.bannercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageControll.currentPage = counter
                counter += 1
            } else {
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.bannercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                pageControll.currentPage = counter
                counter = 1
            }
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
    
    @IBAction func act_Search(_ sender: Any) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            forSearch()
        }else{
            self.logInDtls1()
        }
    }
    @IBAction func act_Notification(_ sender: Any) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.logInDtls1()
        }
        
    }
    
    @IBAction func act_Lespakketten(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LespakketteViewController") as? LespakketteViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func act_Plaatsen(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlaastenVC") as? PlaastenVC
        self.navigationController?.pushViewController(vc!, animated: true)
   }
    
    func bannerApi(){
        let parameters:[String:Any] = ["":""]
              BannerDataResponce.AddUserData(api: "getBanner", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                if let imgdata = data?.responseData{
                    for i in 0..<imgdata.count {
                        self.bannerDataArr.append(imgdata[i])
                    }
                }
                debugPrint(responceCode ?? 0)
//                self.bannercollectionView.delegate = self
//                self.bannercollectionView.dataSource = self
                self.bannercollectionView.reloadData()
                self.pageControll.numberOfPages = self.bannerDataArr.count
                self.pageControll.currentPage = 0
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                }
                debugPrint("Banner_Images:",self.bannerDataArr)
            }
        }
    }
    
    
    // Get booking Api
    func bookingApi(){
        let parameters:[String:Any] = ["date":"no","dateRange":"no","packageType":"0","status": "UPCOMING","take": "ALL"]
        BookingDataResponse.AddUserData(api: "getBooking", parameters: parameters) {
            (data) in
            if data != nil {
               // self.cons_BookingHeight.constant = 250
                let responceCode = data?.responseCode
              // let responseText = data?.responseText
                self.bookingArr = []
                if let data = data?.responseData{
                    for i in 0..<data.count {
                        self.bookingArr.append(data[i])
                    }
                }
                if self.bookingArr.count != 0 {
                    self.vw_BookingFullBg.isHidden = false
                    self.cons_BookingHeight.constant = 175
                }else{
                    self.vw_BookingFullBg.isHidden = true
                    self.cons_BookingHeight.constant = 0
                }
                debugPrint(responceCode ?? 0)
                self.coll_BookingCollectionView.reloadData()
                debugPrint("bookingArr:",self.bookingArr)
                self.coll_BookingCollectionView.reloadData()
            }
        }
    }
    
    // Package Data  PackageDataResponse
    func packageApi(){
        let parameters:[String:Any] = ["":""]
        PackageDataResponse.AddUserData(api: "getPackage", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                if let data = data?.responseData{
                    for i in 0..<data.count {
                        self.lespakkettenArr.append(data[i])
                    }
                }
                self.coll_imgCollectionView.reloadData()
                debugPrint("PackageArr:",self.lespakkettenArr)
                debugPrint(responceCode ?? 0)
            }
        }
    }
    
    // Location Api
    func locationApi(){
        let parameters:[String:Any] = ["":""]
        LocationDataResponse.AddUserData(api: "getLocation", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                if let data = data?.responseData{
                    for i in 0..<data.count {
                        self.locationArr.append(data[i])
                    }
                }
                switch responceCode{
                case 0:
                    debugPrint("000000")
                case 1:
                    debugPrint("1111111")
                default:
                    debugPrint("1111111")
                }
                debugPrint(responceCode ?? 0)
                self.coll_LocationCollectionView.reloadData()
                debugPrint("LocationArr:",self.locationArr)
            }
        }
    }
    
    func howWorkItApi(){
        let parameters:[String:Any] = [:]
        TermConDataResponse.AddUserData(api: "getStaticPage/HOW_DOES_IT_WORK", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData
                self.lbl_HowWorkIt.text = code?.description
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                 print("sucess")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         var numberOfItems = 1
         switch collectionView {
         case bannercollectionView:
            numberOfItems = bannerDataArr.count//bannerImagesArr.count
         case coll_BookingCollectionView:
            numberOfItems = bookingArr.count
         case coll_imgCollectionView:
             numberOfItems = self.lespakkettenArr.count
         case  coll_LocationCollectionView:
            numberOfItems = locationArr.count
         default:
             debugPrint("Somthing went wrong")
         }
         return numberOfItems
        //return bannerImagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch collectionView {
        case bannercollectionView:
            let cell1 = bannercollectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! CollBannerCell
            let dict = bannerDataArr[indexPath.row]
            let img = dict.image ?? ""
            cell1.lbl_vehicleName.text = dict.title
            cell1.lbl_vehicleBrand.text = dict.description
            cell1.bannerImage.sd_setImage(with: URL(string:img), placeholderImage: UIImage(named: "Car1"))
           // cell1.bannerSetup(bannerDataArr[indexPath.row])
            cell = cell1
            
        case coll_BookingCollectionView:
            let cell2 = coll_BookingCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! CustBookingCell
            let dict = bookingArr[indexPath.row]
            let dict2 = dict.trainerInfo
          //  let dict3 = dict.userInfo
            let name = "\(dict2?.first_name ?? "")" + "\(dict2?.last_name ?? "")"
            let imag = dict2?.image ?? ""
            cell2.img_Dp.sd_setImage(with: URL(string: imag))
            cell2.lbl_DriverName.text = name
            cell2.lbl_Date.text = dict.date
            cell2.lbl_time.text = dict.time
            cell2.lbl_rating.text = String(dict2?.totalRating ?? 0)
            cell2.lbl_DriverContctNum.text = dict2?.phone
            
            cell = cell2
        
        case coll_imgCollectionView:
            let lespakkCell = coll_imgCollectionView.dequeueReusableCell(withReuseIdentifier: "lespakkettenCell", for: indexPath) as! CollLespakkettenCell
            let dict = lespakkettenArr[indexPath.row]
            let image = dict.image ?? ""
            lespakkCell.lbl_PackkettenCar.text = dict.name
            lespakkCell.lbl_Type.text = dict.package_type
            self.packType = dict.id ?? 0
//            lespakkCell.lbl_Price.text = String(dict.price ?? 0)
//            lespakkCell.lbl_SpecialPrice.text =  String(dict.special ?? 0)
            lespakkCell.imgView.image = UIImage(named: "image")
            lespakkCell.lbl_Lessons.text = String(dict.no_of_lesson ?? 0) + " Lessons"
            lespakkCell.imgView.sd_setImage(with: URL(string:image), placeholderImage: UIImage(named: "Car1"))
            if let specialPrice =  String(dict.special ?? 0) as? String {
                if specialPrice.isEmpty{
                    lespakkCell.lbl_Price.isHidden = false
                    lespakkCell.lbl_SpecialPrice.text = ""
                    lespakkCell.lbl_SpecialPrice.isHidden = true
                    let str_price =  String(dict.price ?? 0)
                    let attributeString = NSMutableAttributedString(string: str_price)
                    attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
                    attributeString.removeAttribute(NSAttributedString.Key.strikethroughColor, range: NSMakeRange(0, attributeString.length))
                    lespakkCell.lbl_Price.attributedText = attributeString
                    lespakkCell.lbl_Price.textColor = UIColor.black
                   
                }else{
                    lespakkCell.lbl_Price.isHidden = false
                    lespakkCell.lbl_SpecialPrice.isHidden = false
                    let str_price = "€" + String(dict.price ?? 0)
                    let attributeString: NSMutableAttributedString = NSMutableAttributedString(string:str_price)
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                    lespakkCell.lbl_Price.attributedText = attributeString
                    lespakkCell.lbl_Price.textColor = UIColor.lightGray
                    lespakkCell.lbl_SpecialPrice.textColor = UIColor.black
                    lespakkCell.lbl_SpecialPrice.text = "€" + "\(specialPrice)"
                }
            }
            cell = lespakkCell
            
        case coll_LocationCollectionView:
            let cell3 = coll_LocationCollectionView.dequeueReusableCell(withReuseIdentifier: "plastCell", for: indexPath) as! PlaastenCollecCell
            let dict = locationArr[indexPath.row]
            cell3.lbl_Location.text = dict.name //["location"]
            cell = cell3
            
        default:
            debugPrint("Somthing went wrong")
        }
        
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case coll_BookingCollectionView:
            let dict = bookingArr[indexPath.row]
            let dict2 = dict.trainerInfo
            let name = "\(dict2?.first_name ?? "")" + "\(dict2?.last_name ?? "")"
            self.driver_Img = dict2?.image ?? ""
            self.driver_Name = name
            self.driver_Phone = dict2?.phone ?? ""
            self.dri_rating = dict2?.totalRating ?? 0
            self.vechile_Type = String()
            self.ac_date = dict.date ?? ""
            self.ac_time = dict.time ?? ""
            self.ac_location = String()
            let bookingID = dict.id
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"BookingDetails") as? BookingDetails
            vc?.driverImg = driver_Img
            vc?.driverName = driver_Name
            vc?.contact = driver_Phone
            vc?.rating = dri_rating
            vc?.vechileType = vechile_Type
            vc?.date = ac_date
            vc?.time = ac_time
            vc?.location = "HOME"
            vc?.bookingId = bookingID!
            vc?.vechileType = dict.package_type!
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case coll_imgCollectionView:
            let dict = lespakkettenArr[indexPath.row]
            debugPrint("Dict Value :", dict)
            self.packType = dict.id ?? 0
            debugPrint("TypeId :", packType)
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"PackageCarVC") as? PackageCarVC
            vc?.packId = packType
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case coll_LocationCollectionView:
            if  UserDefaults.standard.string(forKey: "user_id") != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"TrainerListVC") as? TrainerListVC
                let dict = locationArr[indexPath.row]
                vc?.lockId = dict.id!
                vc?.locName = dict.name!
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                self.logInDtls1()
            }
        default:
            debugPrint("Somthing went wrong")
        }
    }
}
