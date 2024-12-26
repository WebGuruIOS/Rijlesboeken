//
//  MoreVC.swift
//  Rijlesboeken
//
//  Created by Prince on 27/04/22.
//

import UIKit

class MoreVC: UIViewController {
    @IBOutlet weak var vw_MoreBgView: UIView!{
        didSet{
            vw_MoreBgView.layer.cornerRadius = 40.0
          }
    }
    @IBOutlet weak var vw_TopView: UIView!{
        didSet{
            vw_TopView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var tbl_moretableView: UITableView!
    var meerArr = ["Contact Us","Term & Conditions","About Us","Privacy Policy","FAQ","Feedback About App"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_moretableView.dequeueReusableCell(withIdentifier: "cell") as! MoreTableViewCell
        cell.lbl_title.text = meerArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if meerArr[indexPath.row] == "Contact Us"{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"ContactUsVC") as? ContactUsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else if meerArr[indexPath.row] == "Term & Conditions"{
           // nav_status_delegate = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"TermConditionsVC") as? TermConditionsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else if meerArr[indexPath.row] == "About Us"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"AboutUsVC") as? AboutUsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else if meerArr[indexPath.row] == "Privacy Policy"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"PrivacyPolicyVC") as? PrivacyPolicyVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else if meerArr[indexPath.row] == "FAQ"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"FAQViewController") as? FAQViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            }
        }
    }
