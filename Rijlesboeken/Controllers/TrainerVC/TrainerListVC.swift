//
//  TrainerListVC.swift
//  Rijlesboeken
//
//  Created by Prince on 26/04/22.
//

import UIKit

let list = [VehicleData(sectionType: "Test", vehicleList: ["1","2","3"], vechileName: ["Byke","Moter", "Auto"])]
//let list = [VehicleData(Vlist:)]

class TrainerListVC: UIViewController {
    
    @IBOutlet weak var trainerBgView: UIView!
    @IBOutlet weak var txt_SearchLocation: UITextField!
    @IBOutlet weak var lbl_Location: UILabel!
    @IBOutlet weak var tbl_trainerTblView: UITableView!
    @IBOutlet weak var tbl_PackType: UITableView!
    
    @IBOutlet weak var btn_Filter: UIButton!
    
    @IBOutlet weak var vw_dropDownBgView: UIView!
    @IBOutlet weak var vw_LocationDropDownView: UIView!
    @IBOutlet weak var tbl_LocationDropDown: UITableView!
    @IBOutlet weak var cons_tblHeight: NSLayoutConstraint!
    @IBOutlet weak var cons_tbl_vehiclelist: NSLayoutConstraint!
    
 
    var driverArr = [trainerData]()
    var vehicalType = [packageType]()
    
    var dict_VehiType:[String:Any] = [:]
    var arr_VehiType = [[String:Any]]()
    var dict_Location:[String:Any] = [:]
    var arr_Location = [[String:Any]]()
    
//  var arr_PacksID = [0]
    var lockId = Int()
    var locName = String()
    var packType:String = ""
    var searchedTxt:String = ""
    var locationId = Int()
    var packId:Int = 0
    var trainerId:Int = 0
    var selectedVehicleType = Set<Int>()
    var typeArr = [vechicleTypeDta]()
    var locationArr = [locationResponseData]()
    
    var searchValue = ""
    var vehicleID = ""
    var vechiclID_Arr:[String] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainerBgView.layer.cornerRadius = 40.0
        btn_Filter.isSelected = false
        vw_dropDownBgView.isHidden = true
        self.txt_SearchLocation.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        debugPrint("LocationID:",lockId)
        debugPrint("LocationName:",locName)
        self.lbl_Location.text = locName
        getTrainerApi()
        locationApi()
        packageApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vw_dropDownBgView.isHidden = true

    }
    @IBAction func act_LocationVWDrop(_ sender: Any) {
        vw_LocationDropDownView.isHidden = false
        self.vw_dropDownBgView.isHidden = true
       //locationApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_forLocationBgHide(_ sender: Any) {
        self.vw_LocationDropDownView.isHidden = true
    }
    
    @IBAction func act_ForHideVehicelType(_ sender: Any) {
        self.vw_dropDownBgView.isHidden = true
    }
    
    @IBAction func act_ForHideVehicelType1(_ sender: Any) {
        self.vw_dropDownBgView.isHidden = true
    }
    
    
    @IBAction func act_vehicleType(_ sender: Any) {
        vw_dropDownBgView.isHidden = false
        self.vw_LocationDropDownView.isHidden = true
        self.tbl_PackType.reloadData()
}
    func locationApi(){
        let parameters:[String:Any] = ["":""]
        LocationDataResponse.AddUserData(api: "getLocation", parameters: parameters) {
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                if let data = data?.responseData{
                    self.locationArr = []
                    for i in 0..<data.count {
                        self.locationArr.append(data[i])
                    }
                    self.cons_tblHeight.constant = CGFloat(self.locationArr.count * 50)
                    
                    self.tbl_LocationDropDown.reloadData()
                    debugPrint(responceCode ?? 0)
                }
                debugPrint("LocationArr:",self.locationArr)
            }
        }
    }
    //{locationId?}=If have location pass ID else default value is 0
   // {packageTypeId?} = 1,2
    //{name?}=If have name pass the value alse Default is All
 //getTrainerApi(locId:Int = 1, searchValue: String = "All", vehicleType:Int = 0)
    func getTrainerApi(){
        //locId:Int = 0, searchValue: String = "All", vehicleType:Int = 0
        var vehicleType = "0"
              var locId = "0"
              var searchValue = "All"
              if vechiclID_Arr.count != 0{
                  vehicleType = vechiclID_Arr.joined(separator: ",")
              }
              if txt_SearchLocation.text! != ""{
                  searchValue = txt_SearchLocation.text!
              }
//              if locationId != 0{
//                  locId = "\(locationId)"
//              }
             if lockId != 0{
                locId = "\(lockId)"
              }
        
        let parameters:[String:Any] = ["":""]
        TrainerListResponse.AddUserData(api: "getTrainer/\(locId)/\(searchValue)/\(vehicleType)", parameters: parameters){
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                if let data = data?.responseData{
                    self.driverArr = []
                    for i in 0..<data.count {
                        self.driverArr.append(data[i])
                    }
                }
                self.tbl_trainerTblView.reloadData()
                debugPrint("DriverArr:",self.driverArr)
                ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                
                if data != nil {
                    if responseCode == 0{
                        
                    }else{
                        if let data1 = data?.responseData?[0] as trainerData?{
                            self.dict_VehiType.removeAll()
                            self.arr_VehiType = []
                            for items in data1.packageType ?? []{
                                self.vehicalType.append(items)
                                debugPrint("id_Value:",items.id ?? 0)
                                self.dict_VehiType["vehicleId"] = items.id ?? 0
                                self.dict_VehiType["vehicleType"] = items.name ?? ""
                                self.arr_VehiType.append(self.dict_VehiType)
                                
                            }
                            debugPrint("Vehicle Type:",self.arr_VehiType)
                        }
                    }
                }
                if data != nil {
                    if responseCode == 0{
                    }else{
                        if let data2 = data?.responseData?[0] as trainerData?{
                            self.dict_Location.removeAll()
                            self.arr_Location = []
                            self.trainerId = data2.id ?? 0
                            for items in data2.location ?? []{
                                self.dict_Location["locationId"] = items.id
                                self.dict_Location["locationName"] = items.name
                                self.arr_Location.append(self.dict_Location)  //add(self.dict_Location)
                                debugPrint("Location Value:",self.arr_Location)
                            }
                        }
                    }
                }
                self.tbl_LocationDropDown.reloadData()
            }
        }
    }
    
    // Vehicle type
    func packageApi(){
        let parameters:[String:Any] = ["":""]
        VehicleDataResponse.AddUserData(api: "getPackageType", parameters: parameters){
            (data) in
            if data != nil {
                let responceCode = data?.responseCode
                self.typeArr = []
                if let data1 = data?.responseData{
                    for i in 0..<data1.count{
                        self.typeArr.append(data1[i])
                    }
                }
                self.cons_tbl_vehiclelist.constant = CGFloat(self.typeArr.count * 50)
                debugPrint(responceCode ?? 0)
            }
            self.tbl_PackType.reloadData()
        }
    }
}

extension TrainerListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfItems = 1
        switch tableView {
        case tbl_LocationDropDown:
            numberOfItems = locationArr.count
        case tbl_trainerTblView:
        numberOfItems = driverArr.count
        case tbl_PackType:
        numberOfItems = typeArr.count
        default:
        debugPrint("Somthing went wrong")
    }
        return numberOfItems
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case tbl_LocationDropDown:
            let cell1 = tbl_LocationDropDown.dequeueReusableCell(withIdentifier: "cell") as! LocationDropTVCell
            let dict = locationArr[indexPath.row]
            cell1.selectionStyle = .none
            cell1.lbl_Location.text = dict.name//dict["locationName"] as? String
            cell = cell1
            
        case tbl_trainerTblView:
            let cell2 = self.tbl_trainerTblView.dequeueReusableCell(withIdentifier: "cell") as! TrainerListsTVCell
            let dict = driverArr[indexPath.row]
            let dict1:[String:Any] = arr_VehiType[indexPath.row]
            debugPrint("All Vechiles",dict1)
            let img = dict.image ?? ""
            cell2.img_DriverDp.sd_setImage(with: URL(string:img), placeholderImage: UIImage(named: "Car1"))
            cell2.lbl_drivername.text = dict.name
            cell2.lbl_Contact.text = dict.phone
            cell2.lists = dict.packageType ?? []
           // cell2.lbl_Auto.text = dict1["vehicleType"] as? String
//            if vehicalType.count >= 3{
//                cell2.lbl_Auto.text = vehicalType[0].name
//                cell2.lbl_Scooter.text = vehicalType[1].name
//                cell2.lbl_MotorByke.text = vehicalType[2].name
//            }
            
//            if vehicalType.count >= 2{
//                cell2.lbl_Auto.text = vehicalType[0].name
//                cell2.lbl_Scooter.text = vehicalType[1].name
//                
//            }
//            cell2.lbl_Scooter.text = ""
//            cell2.lbl_MotorByke.text = ""
//            let rr = vehicalType[indexPath.row]
//            let kk = rr.name
//            if vehicalType.contains("Motorfiets"){
//            }
            
//            cell2.lbl_Scooter.text = "Scooter"
//            cell2.lbl_MotorByke.text = "Motorfiets"
            cell2.lbl_Rating.text = String(dict.totalRating ?? 0)
            cell2.selectionStyle = .none
            cell2.btn_Book.tag = indexPath.row
            cell2.btn_Book.addTarget(self, action:#selector(clickedOnBook(sender:)), for: .touchUpInside)
            cell = cell2
            
        case tbl_PackType:
            let cell3 = self.tbl_PackType.dequeueReusableCell(withIdentifier: "cell") as! PackageTypeTVCell
            let dict = typeArr[indexPath.row]
            cell3.lbl_PackType.text = dict.name
            if vechiclID_Arr.contains("\(typeArr[indexPath.row].id ?? 0)"){
                cell3.img_ChechUncheck.image = #imageLiteral(resourceName: "CheckMark")
                cell3.img_ChechUncheck.tintColor = .orange
            }else{
                cell3.img_ChechUncheck.image = #imageLiteral(resourceName: "Uncheck")
                cell3.img_ChechUncheck.tintColor = .lightGray
            }
            
            cell3.selectionStyle = .none
            cell = cell3
        default:
            debugPrint("Somthing went wrong")
        }
       return cell
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case tbl_LocationDropDown:
            let dict = locationArr[indexPath.row]
            lockId = dict.id!
            self.locName = dict.name ?? ""
            self.lbl_Location.text = self.locName
            print("locationId:",locationId)
            self.getTrainerApi()
            
        case tbl_PackType:
            if vechiclID_Arr.contains("\(typeArr[indexPath.row].id ?? 0)"){
                let index = vechiclID_Arr.firstIndex{$0 == ("\(typeArr[indexPath.row].id ?? 0)")}
                vechiclID_Arr.remove(at: index ?? 0)
                print("Vechiles:",vechiclID_Arr)
            }else{
                vechiclID_Arr.append("\(typeArr[indexPath.row].id ?? 0)")
                print("Vechiles:",vechiclID_Arr)
            }
            self.getTrainerApi()
            
            self.vw_dropDownBgView.isHidden = true
            
        case tbl_trainerTblView:
             print("Hello ")
        default:
            debugPrint("Somthing went wrong")
        }
        vw_LocationDropDownView.isHidden = true
    }
    
    @objc func clickedOnBook(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row:tag, section:0)
        debugPrint(indexPath)
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AvailabilityVC") as? AvailabilityVC
        let dict = driverArr[indexPath.row]
        vc?.driver_Id = dict.id ?? 0//trainerId
        vc?.driverName = dict.name ?? ""
        vc?.driverImg = dict.image ?? ""
        vc?.driverMob = dict.phone!
        vc?.driverRating = dict.totalRating ?? 0
        vc?.lists = dict.packageType ?? []
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}


extension TrainerListVC: UITextFieldDelegate{
       func textFieldDidEndEditing(_ textField: UITextField) {
        debugPrint("Text Value:",textField.text ?? "")
        if textField.text != ""{
            self.getTrainerApi()
            debugPrint("Clicked Done")
        }else{
            self.getTrainerApi()
        }
        self.txt_SearchLocation.resignFirstResponder()
        
       }
  }
