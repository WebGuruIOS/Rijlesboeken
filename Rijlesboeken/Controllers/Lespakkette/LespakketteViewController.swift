//
//  LespakketteViewController.swift
//  Rijlesboeken
//
//  Created by Prince on 26/04/22.
//

import UIKit

class LespakketteViewController: UIViewController {

    @IBOutlet weak var lespaBgView: UIView!{
        didSet{
            lespaBgView.clipsToBounds = true
            lespaBgView.layer.cornerRadius = 40.0
        }
    }
    
    @IBOutlet weak var vw_topview: UIView!{
        didSet{
            vw_topview.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var tbl_LespakkTblView: UITableView!
    
    var lespakkettenArr = [packageDataResponse]()
    var id_pack:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.packageApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func act_Notification(_ sender: Any) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            self.logInDtls1()
        }
        
    }
    
    @IBAction func act_Search(_ sender: Any) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            forSearch()
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
    
    
    
    // Package Data  PackageDataResponse
      func packageApi() {
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
                self.tbl_LespakkTblView.reloadData()
                debugPrint("PackageArr:", self.lespakkettenArr)
                debugPrint(responceCode ?? 0)
            }
        }
    }
}

extension LespakketteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lespakkettenArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_LespakkTblView.dequeueReusableCell(withIdentifier: "cell") as! LespakketteTblCell
        let dict = lespakkettenArr[indexPath.row]
        let img = dict.image ?? ""
        cell.img_Vehicle.sd_setImage(with: URL(string:img),
        placeholderImage: UIImage(named: "Car1"))
        cell.lbl_Packagetype.text = dict.name
        self.id_pack = dict.id ?? 0
//        cell.lbl_Price.text! = String(dict.price ?? 0)
//        cell.lbl_SpecialPrice.text = String(dict.special ?? 0)
        cell.lbl_vehicleType.text = dict.package_type
        cell.lbl_Lesson.text = String(dict.no_of_lesson ?? 0) + " Lessons"
        cell.selectionStyle = .none
        if let specialPrice =  String(dict.special ?? 0) as? String{
            if specialPrice.isEmpty{
                cell.lbl_Price.isHidden = false
                cell.lbl_SpecialPrice.text = ""
                cell.lbl_SpecialPrice.isHidden = true
                let str_price =  String(dict.special ?? 0)
                let attributeString = NSMutableAttributedString(string: str_price)
                attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
                attributeString.removeAttribute(NSAttributedString.Key.strikethroughColor, range: NSMakeRange(0, attributeString.length))
                cell.lbl_Price.attributedText = attributeString
                cell.lbl_Price.textColor = UIColor.black
            }else{
                cell.lbl_Price.isHidden = false
                cell.lbl_SpecialPrice.isHidden = false
                let str_price = "€" + String(dict.price ?? 0)
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string:str_price)
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                cell.lbl_Price.attributedText = attributeString
                cell.lbl_Price.textColor = UIColor.lightGray
                cell.lbl_SpecialPrice.textColor = UIColor.black
                cell.lbl_SpecialPrice.text = "€" + "\(specialPrice)"
            }
        }
        cell.btn_ViewDetails.tag = indexPath.row
        cell.btn_ViewDetails.addTarget(self, action:#selector(clickedOnViewDtls(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func clickedOnViewDtls(sender:UIButton){
        _ = sender.tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"PackageCarVC") as? PackageCarVC
        vc?.packId = id_pack
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


