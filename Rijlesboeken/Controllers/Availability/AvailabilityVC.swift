//
//  AvailabilityVC.swift
//  Rijlesboeken
//
//  Created by Prince on 12/05/22.
//

import UIKit

class AvailabilityVC: UIViewController {

    @IBOutlet weak var coll_TimeSlotCollectionView: UICollectionView!
    @IBOutlet weak var coll_CalenderCollection: UICollectionView!
    @IBOutlet weak var vw_TimeSlotBg: UIView!
    @IBOutlet weak var vw_DriverDtlsBg: UIView!
    @IBOutlet weak var driverBGView: UIView!
    
    @IBOutlet weak var lbl_DriverName: UILabel!
    @IBOutlet weak var lbl_ContactNo: UILabel!
    @IBOutlet weak var imgDriverDP: UIImageView!
    @IBOutlet weak var imgRating: UIImageView!
    @IBOutlet weak var lbl_RatingNumber: UILabel!
    @IBOutlet weak var vw_CalenderBgView: UIView!
    @IBOutlet weak var selectPackBgView: UIView!
   
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var vw_TimeBgView: UIView!
    
    // DAY BG VIEW OF CALENDER
    @IBOutlet weak var vw_SundayBGView: UIView!
    @IBOutlet weak var vw_MondayBgView: UIView!
    @IBOutlet weak var vw_TuesdayBgView: UIView!
    @IBOutlet weak var vw_WednesdayBgView: UIView!
    @IBOutlet weak var vw_ThursdayBgView: UIView!
    @IBOutlet weak var vw_FridayBgView: UIView!
    @IBOutlet weak var vw_SaturdayBGView: UIView!
    
    @IBOutlet weak var coll_DriverVehicles: UICollectionView!
    // My Pickup location
    @IBOutlet weak var vw_PickView: UIView!
    @IBOutlet weak var btn_Home: UIButton!
    @IBOutlet weak var btn_Work: UIButton!
    
    @IBOutlet weak var lbl_NotimeSlot: UILabel!
    @IBOutlet weak var con_NoTimeBgViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var timeSlotconstantHight: NSLayoutConstraint!
    @IBOutlet weak var timeslotBgViewConsHight: NSLayoutConstraint!
    
    @IBOutlet weak var vw_ConfirmBookingBG: UIView!
    //Package type collection view
    @IBOutlet weak var coll_VehiclePackageType: UICollectionView!
    
    
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    var driver_Id = Int()
    var driverName = ""
    var driverImg = ""
    var driverRating = Int()
    var driverVehicles = [""]
    var driverMob = ""
    var driverArr = [trainerData]()
    var trainertime = [responseTimeData]()
    var packageType = [typeresponse]()
    var str_currMonth:String = ""
    var str_currDays:String = ""
    var str_calMonth:String = ""
    var str_SelectTimeSlot:String = ""
    var str_SelectDate:String = ""
    var compDate:String = ""
    var selected_VehType:Int = 0
    var addressType = ""//:String = "HOME"
    var validStatus:Bool = false
    var pickAddress = [addressData]()
    var addressSetting = Int()
    var workAddressSetting = Int()
    var dataCount = Int()
    var lists:[packageType] = []
    
    
  //  var slotArr = ["12:00-14:00","10:00-12:00","13:30-15:30","08:00-10:00","21:15-23:15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidloadWorks()
        
        coll_DriverVehicles.delegate = self
        coll_DriverVehicles.dataSource = self
        coll_DriverVehicles.register(UINib(nibName: "Coll_VehicleTypeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "typeCell")
        
        self.lbl_DriverName.text = driverName
        self.lbl_RatingNumber.text = String(driverRating)
        self.lbl_ContactNo.text = driverMob
        self.imgDriverDP.sd_setImage(with: URL(string: driverImg))
        
    }
    
    
//    @objc func labelClicked(_ sender: Any) {
//
//        print("UILabel clicked")
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currDate = getCurrentDate()
        self.getTimeApi(driverId: driver_Id, date: currDate)
       // self.getPackageTypeApi()
        
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"  //"dd-MM-yyyy"
        let dateString = formatter.string(from: Date())
        debugPrint("Day of month:",dateString)
        return dateString
    }
    
    /*
     let dateFormatterGet = NSDateFormatter()
     dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

     let dateFormatterPrint = NSDateFormatter()
     dateFormatterPrint.dateFormat = "MMM dd,yyyy"

     let date: NSDate? = dateFormatterGet.dateFromString("2016-02-29 12:24:26")
     print(dateFormatterPrint.stringFromDate(date!))
     */
    
    func getCurrentMonth()->String{
        let formatter = DateFormatter()
            formatter.locale = Locale.current
            formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
            let dateString = formatter.string(from: Date())
       debugPrint("Day of month:",dateString)
        return dateString
    }
    func getCurrDays()->String{
        let formatter = DateFormatter()
            formatter.locale = Locale.current
            formatter.setLocalizedDateFormatFromTemplate("d") //MMM d, yyyy
            let daysString = formatter.string(from: Date())
       debugPrint("Day of month:",daysString)
        return daysString
    }
    
    func setCellsView(){
        let width = (coll_CalenderCollection.frame.size.width - 2) / 8
        let height = (coll_CalenderCollection.frame.size.height - 2) / 8
        let flowLayout = coll_CalenderCollection.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView(){
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        var count: Int = 1
        while(count <= 42){
            if(count <= startingSpaces || count - startingSpaces > daysInMonth){
                totalSquares.append("")
            }else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        + " " + CalendarHelper().yearString(date: selectedDate)
        str_calMonth = CalendarHelper().monthString(date: selectedDate)
        + " " + CalendarHelper().yearString(date: selectedDate)
        debugPrint("Current Month :",str_calMonth)
        debugPrint("Month Name :",monthLabel ?? "")
        coll_CalenderCollection.reloadData()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func act_ConformBooking(_ sender: Any) {
        validStatus = true
        if str_SelectTimeSlot == "" {
            validStatus = false
            ApiService.shared.showAlert(title: "", msg: "Please select a timeslot")
        }
        if selected_VehType == 0 {
            validStatus = false
            ApiService.shared.showAlert(title: "", msg: "Please select a Package Type")
        }
        if self.addressType.isEmpty{
            validStatus = false
            ApiService.shared.showAlert(title: "", msg: "Please select address")
        }
        if validStatus{
            self.saveBookingApi()
        }
    }
    
    @IBAction func act_Home(_ sender: Any) {
        self.workAddressSetting = 0
        self.pickLocationApi()
    }
    
    @IBAction func act_Work(_ sender: Any) {
        self.workAddressSetting = 1
        self.pickLocationApi()
        
    }
    
    @IBAction func act_NextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func act_PreMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
  
   func pickLocationApi() {
       let parameters:[String:Any] = [:]
       PickDataResponse.AddUserData(api: "getAddress", parameters:parameters) {
           (data) in
           if data != nil {
               if let data1 = data?.payload{
                   self.dataCount = data1.count
                   self.pickAddress = []
                   for i in 0..<data1.count {
                       self.pickAddress.append(data1[i])
                   }
                   if data?.status != 0{
                       if self.workAddressSetting == 1{
                           if self.dataCount == 2{
                               if let workData = data?.payload?[1] as addressData?{
                                   self.addressType = workData.type ?? ""
                                   self.btn_Work.isSelected = true
                                   self.btn_Work.tintColor = .orange
                                   self.btn_Home.isSelected = false
                                   self.btn_Home.tintColor = .darkGray
                     }
                           }else{
                               self.updateAdrsAlert()
                           }
                           
                       }else{
                           if let homeData = data?.payload?[0] as addressData?{
                               self.addressType = homeData.type ?? "" //"HOME"
                               self.btn_Home.isSelected = true
                               self.btn_Home.tintColor = .orange
                               self.btn_Work.isSelected = false
                               self.btn_Work.tintColor = .darkGray
                      }
                    }
                   }else{
                       // self.addressType = ""
                        self.btn_Work.isSelected = false
                        self.btn_Work.isSelected = false
                        self.logInDtls1()
                }
            }
           }
       }
   }
   
     func getTimeApi(driverId:Int, date: String) {
         let parameters:[String:Any] = ["":""]
     TimeDataResponse.AddUserData(api: "getAvailabilityTime/\(driverId)/\(date)", parameters: parameters){
             (data) in
             if data != nil {
                 let responseCode = data?.responseCode
                 let responseText = data?.responseText
               //  let responseData = data?.responseData
                if let data = data?.responseData{
                    self.trainertime = []
                    for i in 0..<data.count {
                        self.trainertime.append(data[i])
                    }
                    self.coll_TimeSlotCollectionView.reloadData()
                  
                    
                    
                }
               debugPrint("trainertime:",self.trainertime)
                switch responseCode {
                case 1:
                    if self.trainertime.count == 1{
                        self.timeSlotconstantHight.constant = CGFloat(self.trainertime.count * 85)
                    }else{
                        self.timeSlotconstantHight.constant = CGFloat((self.trainertime.count / 2) * 85)
                        self.coll_TimeSlotCollectionView.reloadData()
                        self.lbl_NotimeSlot.isHidden = true
                        self.con_NoTimeBgViewHeight.constant = 25
                    }
                    
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                case 0:
                    self.lbl_NotimeSlot.isHidden = false
                    self.con_NoTimeBgViewHeight.constant = 50
                    self.timeSlotconstantHight.constant = 3
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                }
            }
         }
     }

//     func getPackageTypeApi() {
//         let parameters:[String:Any] = ["":""]
//     PackageTypeDataResponse.AddUserData(api: "getPackageType", parameters: parameters){
//             (data) in
//             if data != nil {
//                if let data = data?.responseData{
//                    self.packageType = []
//                    for i in 0..<data.count {
//                        self.packageType.append(data[i])
//                    }
//                }
//                self.coll_VehiclePackageType.reloadData()
//            }
//         }
//     }
    
    func saveBookingApi() {
        let parameters:[String:Any] = ["date":compDate,"location_type":addressType,"package_type":selected_VehType, "time":str_SelectTimeSlot,"trainer_id":driver_Id]
        debugPrint("Params Value :",parameters)
        SaveBookingDataResponse.AddUserData(api: "saveBooking", parameters: parameters){
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                switch responseCode  {
                case 1:
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpcomingBookingVC") as? UpcomingBookingVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                default:
                    debugPrint("Something went wrong")
                }
             }
           }
        }
    
    
    func logInDtls1(){
        let alertController = UIAlertController(title: "Update Address", message: "Home Address is not available!.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        let ok = UIAlertAction(title: "Update" , style: .default){ (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyPickupLocationVC") as! MyPickupLocationVC
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func updateAdrsAlert(){
        let alertController = UIAlertController(title: "Update Address", message: "Work Address is not available!.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        let ok = UIAlertAction(title: "Update" , style: .default){ (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyPickupLocationVC") as! MyPickupLocationVC
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    
    func viewDidloadWorks(){
        Shadow.add(view: driverBGView, color: .lightGray)
        self.vw_ConfirmBookingBG.roundCorners(corners: [.bottomRight, .bottomLeft, .topRight], radius: 25)
        setCellsView()
        setMonthView()
        vw_TimeBgView.layer.cornerRadius = 10.0
        vw_BgView.layer.cornerRadius = 40.0
        vw_DriverDtlsBg.layer.cornerRadius = 10.0
        vw_CalenderBgView.layer.cornerRadius = 10.0
        vw_TimeSlotBg.layer.cornerRadius = 10.0
        vw_CalenderBgView.layer.cornerRadius = 10.0
        vw_PickView.layer.cornerRadius = 10.0
        selectPackBgView.layer.cornerRadius = 10.0
        // Day Bg View
        vw_SundayBGView.layer.cornerRadius = vw_SundayBGView.layer.frame.height / 2
        vw_MondayBgView.layer.cornerRadius = vw_MondayBgView.layer.frame.height / 2
        vw_TuesdayBgView.layer.cornerRadius = vw_TuesdayBgView.layer.frame.height / 2
        vw_WednesdayBgView.layer.cornerRadius = vw_WednesdayBgView.layer.frame.height / 2
        vw_ThursdayBgView.layer.cornerRadius = vw_ThursdayBgView.layer.frame.height / 2
        vw_FridayBgView.layer.cornerRadius = vw_FridayBgView.layer.frame.height / 2
        vw_SaturdayBGView.layer.cornerRadius = vw_SaturdayBGView.layer.frame.height / 2
        imgDriverDP.layer.cornerRadius = imgDriverDP.layer.frame.height / 2

        vw_TimeSlotBg.layer.cornerRadius = 10.0
        
        str_currMonth = getCurrentMonth()
        debugPrint("Str_CurrentMonth:",str_currMonth)
        str_currDays = getCurrDays()
        debugPrint("Str_CurrentDays:",str_currDays)
      }
    }
    
extension AvailabilityVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems = 1
        switch collectionView {
        case coll_TimeSlotCollectionView:
            numberOfItems = trainertime.count // slotArr
            debugPrint("numberOfItems",numberOfItems)
        case coll_CalenderCollection:
           numberOfItems = totalSquares.count
        case coll_VehiclePackageType:
            numberOfItems = lists.count  //packageType.count
        case coll_DriverVehicles:
            numberOfItems = lists.count
        default:
            debugPrint("Somthing went wrong")
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch collectionView {
        case coll_TimeSlotCollectionView:
        let cell1 = coll_TimeSlotCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustAvailabilityCollViewCell
            let dict = trainertime[indexPath.row]
            debugPrint("Times:",dict)
            cell1.lbl_Time.text = dict.time
            cell = cell1
            
        case coll_CalenderCollection:
            let cell2 = coll_CalenderCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalenderCell
            cell2.dayOfMonth.text = totalSquares[indexPath.row]
            let caldate = totalSquares[indexPath.row]
            if str_currMonth == str_calMonth{
                if caldate == str_currDays{
                   // cell2.dayOfMonth.backgroundColor = .orange
                    cell2.vw_DateBgView.backgroundColor = .orange
                }else{
                   // cell2.dayOfMonth.backgroundColor = .lightGray
                }
                debugPrint("If_str_calMonth",str_calMonth)
            }else{
                debugPrint("Else_str_calMonth",str_calMonth)
            }
            cell = cell2
            
        case coll_VehiclePackageType:
            let packType = coll_VehiclePackageType.dequeueReusableCell(withReuseIdentifier: "packagetypeCell", for: indexPath) as! Coll_PackageType
         // let dict = packageType[indexPath.row]
            packType.lbl_VehicleType.text = lists[indexPath.item].name  //dict.name
          //  debugPrint("Vehicle Type:",dict.name ?? "")
            cell = packType
            
        case coll_DriverVehicles:
            let cells = self.coll_DriverVehicles.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! Coll_VehicleTypeCell
            cells.lbl_VehicleName.text = lists[indexPath.item].name
            cell = cells
            
        default:
            debugPrint("Somthing went wrong")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       var width = CGFloat()
        let height = CGFloat()

        let noOfColumn = 2
        let collectionviewWidth = collectionView.frame.width
        let bothEdge =  CGFloat(5 + 5) // left + right
        let excludingEdge = collectionviewWidth - bothEdge
        let cellWidthExcludingSpaces = excludingEdge - (CGFloat((noOfColumn - 1)) * 2.0)
        let finalCellWidth = CGFloat(cellWidthExcludingSpaces / CGFloat(noOfColumn))
        _ = finalCellWidth
        
        width = finalCellWidth
        //height = finalCellWidth * 1.50
        
        return CGSize(width:width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       switch collectionView {
        case coll_TimeSlotCollectionView:
           let cell1 = coll_TimeSlotCollectionView.cellForItem(at: indexPath) as! CustAvailabilityCollViewCell
           let dict = trainertime[indexPath.row]
           cell1.lbl_Time.text = dict.time
            str_SelectTimeSlot = dict.time ?? ""
            debugPrint("Clicked Times:",dict.time ?? "")
           if(cell1.isSelected){
               cell1.img_Bgimage.tintColor = UIColor.orange
              
                  }else{
                      cell1.img_Bgimage.tintColor = UIColor.clear
                    
                }
           
       case coll_CalenderCollection:
           let calenderCell = coll_CalenderCollection.cellForItem(at: indexPath) as! CalenderCell
           if(calenderCell.isSelected){
               //calenderCell.vw_DateBgView.backgroundColor = UIColor.orange
             
                  }else{
                      calenderCell.vw_DateBgView.backgroundColor = UIColor.clear
                }
           
        let ff = totalSquares[indexPath.item]
        str_SelectDate = ff
//        let selectedDateFromCal = "\(ff) \(str_calMonth)"
//        print("Selected date:",selectedDateFromCal)
           
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = "MMMM yyyy"
           let date = dateFormatter.date (from: str_calMonth)
           debugPrint("Changed Date",date ?? Date())
           
           let formatter = DateFormatter()
               formatter.locale = Locale.current
               formatter.setLocalizedDateFormatFromTemplate("yyyy.MM")
           let dateString = formatter.string(from: date ?? Date())
          debugPrint("Day of month:",dateString)
          
           let monthYrsArr = dateString.components(separatedBy: "/")
           let mnth = monthYrsArr[0]
           let yrs = monthYrsArr[1]
           compDate = "\(yrs)-\(mnth)-\(ff)"
           debugPrint("Complete Date:",compDate)
           self.getTimeApi(driverId: driver_Id, date: compDate)
        
       case coll_VehiclePackageType:
        let typePack = coll_VehiclePackageType.cellForItem(at: indexPath) as! Coll_PackageType
        let dict = lists[indexPath.item]
        self.selected_VehType = dict.id ?? 0
        debugPrint("Vehicle Type:",selected_VehType )
        typePack.vw_TypeBgView.backgroundColor = .orange
        
       default:
            debugPrint("Somthing went wrong")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       switch collectionView {
        case coll_TimeSlotCollectionView:
           let cell1 = coll_TimeSlotCollectionView.cellForItem(at: indexPath) as! CustAvailabilityCollViewCell
            cell1.img_Bgimage.tintColor = UIColor(named: "lightorange")
           
        case coll_CalenderCollection:
           let calCell = coll_CalenderCollection.cellForItem(at: indexPath) as! CalenderCell
           calCell.vw_DateBgView.backgroundColor = .clear
           
       case coll_VehiclePackageType:
        let typePack = coll_VehiclePackageType.cellForItem(at: indexPath) as! Coll_PackageType
        typePack.vw_TypeBgView.backgroundColor = UIColor(named: "lightorange")
       default:
            debugPrint("Somthing went wrong")
        }
    }
}

