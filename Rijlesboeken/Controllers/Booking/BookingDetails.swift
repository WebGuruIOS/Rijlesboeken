//
//  BookingDetails.swift
//  Rijlesboeken
//
//  Created by Prince on 29/04/22.
//

import UIKit

class BookingDetails: UIViewController {
    @IBOutlet weak var vw_DtlsBgView: UIView!{
        didSet{
            vw_DtlsBgView.layer.cornerRadius = 40.0
        }
    }
    
    @IBOutlet weak var vw_lbltypeBG: UIView!
    @IBOutlet weak var lbl_Type: UILabel!
    
    @IBOutlet weak var vw_DriverDtlsView: UIView!
    @IBOutlet weak var vw_TimeDateBgView: UIView!
    @IBOutlet weak var img_Dp: UIImageView!
    @IBOutlet weak var vw_Dpimgview: UIView!
    @IBOutlet weak var vw_TimeBgView: UIView!
    
    @IBOutlet weak var lbl_DriverName: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var rating_Img: UIImageView!
   
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
   
    @IBOutlet weak var vw_commentFullBgView: UIView!
    @IBOutlet weak var vw_PickBgView: UIView!
    @IBOutlet weak var btn_Home: UIButton!
    @IBOutlet weak var btn_Work: UIButton!
    @IBOutlet weak var txt_Coment: UITextView!
    @IBOutlet weak var vw_CommentTextBG: UIView!
    
    @IBOutlet weak var vw_CancelRequest: UIView!
    @IBOutlet weak var vw_Reschedule: UIView!
    
    var driverImg = String()
    var driverName = String()
    var contact = String()
    var rating = Int()
    var vechileType = String()
    var date = String()
    var time = String()
    var location = String()
    var bookingId = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewDidLoadWorks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.lbl_DriverName.text = driverName
        self.lbl_Mobile.text = contact
        let img = driverImg
        self.img_Dp.sd_setImage(with: URL(string: img))
        self.lbl_Date.text = date
        self.lbl_Time.text = time
        debugPrint("Driver Dp:",driverImg)
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)    }
    
    
    @IBAction func act_Home(_ sender: Any) {
        btn_Home.isSelected = true
        btn_Home.tintColor = .orange
        btn_Work.isSelected = false
        btn_Work.tintColor = .darkGray
    }
    
    @IBAction func act_Work(_ sender: Any) {
        btn_Work.isSelected = true
        btn_Work.tintColor = .orange
        btn_Home.isSelected = false
        btn_Home.tintColor = .darkGray
    }
    
    @IBAction func act_CancleRequest(_ sender: Any) {
        if txt_Coment.text.isEmpty{
            ApiService.shared.showAlert(title: "", msg: "Please enter your comment")
        }else{
            let comment = txt_Coment.text!
            let type = "CANCELED"
            bookingStatusApi(comment:comment, type:type)
        }
    }
    
    @IBAction func act_RequestReshedule(_ sender: Any) {
        if txt_Coment.text.isEmpty{
            ApiService.shared.showAlert(title: "", msg: "Please enter your comment")
        }else{
        let comment = txt_Coment.text!
        let type = "RESCHEDULE"
        bookingStatusApi(comment:comment, type:type)
    }
 }
    
    func bookingStatusApi(comment:String, type:String){
        let parameters:[String:Any] = ["booking_id": "\(bookingId)","comment": comment,"type": type]
        BookingStatusDataResponse.AddUserData(api: "statusBooking", parameters: parameters){
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                switch responseCode {
                    case 1:
                    self.navigationController?.popViewController(animated: true)
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                    case 2:
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                    default :
                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
                }
            }
        }
    }
    
    func viewDidLoadWorks(){
        
//        coll_VehicleList.delegate = self
//        coll_VehicleList.dataSource = self
//        coll_VehicleList.register(UINib(nibName: "Coll_VehicleTypeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "typeCell")
        
        
        vw_lbltypeBG.layer.cornerRadius = vw_lbltypeBG.layer.frame.height / 2
        self.lbl_Type.text = vechileType
        self.lbl_Rating.text = String(rating)
        Shadow.add(view: vw_TimeBgView, color: .lightGray)
        Shadow.add(view: vw_PickBgView, color: .lightGray)
        Shadow.add(view: vw_commentFullBgView, color: .lightGray)
        self.vw_CancelRequest.roundCorners(corners: [.topLeft, .bottomRight, .bottomLeft], radius: 25)
        self.vw_Reschedule.roundCorners(corners: [.bottomLeft, .bottomRight, .topRight], radius: 25)
        vw_DriverDtlsView.layer.cornerRadius = 10.0
        vw_TimeDateBgView.layer.cornerRadius = 10.0
        vw_Dpimgview.layer.cornerRadius = vw_Dpimgview.layer.frame.height / 2
        vw_TimeBgView.layer.cornerRadius = 10.0
        img_Dp.layer.cornerRadius = img_Dp.layer.frame.height / 2
        vw_commentFullBgView.layer.cornerRadius = 10.0
        vw_CommentTextBG.layer.cornerRadius = 10.0
        vw_CommentTextBG.layer.borderWidth = 1.0
        vw_CommentTextBG.layer.borderColor = UIColor.lightGray.cgColor
        vw_PickBgView.layer.cornerRadius = 10.0
        btn_Home.isSelected = true
        btn_Home.tintColor = .orange
    }
}
//extension BookingDetails: UICollectionViewDelegate, UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list[coll_VehicleList.tag].vechileName.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = self.coll_VehicleList.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! Coll_VehicleTypeCell
//        cell.lbl_VehicleName.text = list[coll_VehicleList.tag].vechileName[indexPath.row]
//        return cell
//    }
//}
