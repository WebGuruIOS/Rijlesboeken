//
//  PlaastenVC.swift
//  Rijlesboeken
//
//  Created by Prince on 26/04/22.
//

import UIKit

class PlaastenVC: UIViewController {

    @IBOutlet weak var vw_tblBGView: UIView!
    @IBOutlet weak var vw_PlaastBgView: UIView!{
          didSet{
            vw_PlaastBgView.clipsToBounds = true
            vw_PlaastBgView.layer.cornerRadius = 40.0
        }
    }
    
    @IBOutlet weak var vw_topView: UIView!{
        didSet{
            vw_topView.layer.cornerRadius = 10.0
        }
    }
    
    @IBOutlet weak var tbl_plaasttblView: UITableView!
  
    var locationArr =  [locationResponseData]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationApi()
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
                    self.tbl_plaasttblView.reloadData()
                    debugPrint(responceCode ?? 0)
                }
                debugPrint("LocationArr:",self.locationArr)
            }
        }
    }
}

extension PlaastenVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_plaasttblView.dequeueReusableCell(withIdentifier: "cell") as! PlaastenTableViewCell
        let dict = locationArr[indexPath.row]
        cell.lbl_location.text = dict.name
        cell.imgLocation.image = UIImage(named: "location1x")
       // cell.vw_plastBgView.image = UIImage(named: "Plastbgimg")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  UserDefaults.standard.string(forKey: "user_id") != nil {
            let dict = locationArr[indexPath.row]
            let locaid = dict.id
            let locName = dict.name
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"TrainerListVC") as? TrainerListVC
            vc?.locName = locName ?? ""
            vc?.lockId = locaid ?? 0
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else{
            self.logInDtls1()
        }
    }
}
    
    

