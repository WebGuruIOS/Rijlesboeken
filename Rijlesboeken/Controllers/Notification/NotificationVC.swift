//
//  SearchVC.swift
//  Rijlesboeken
//
//  Created by Prince on 01/05/22.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var vw_Nonotification: UIView!
    @IBOutlet weak var vw_BgView: UIView!
    @IBOutlet weak var tbl_Notification: UITableView!
    var notificationData:[notificationData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.tbl_Notification.delegate = self
        self.tbl_Notification.dataSource = self
        self.vw_Nonotification.isHidden = true
        vw_BgView.layer.cornerRadius = 40.0
        notificationApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func notificationApi(){
        let parameters:[String:Any] = [:]
        NotificationResponseData.AddUserData(api: "getNotifications", parameters: parameters){ [self]
            (data) in
            if data != nil {
              //  let responseCode = data?.responseCode
              //  let responseText = data?.responseText
               // let respoceData = data?.responseData
                if let data = data?.responseData {
                    self.notificationData = []
                    for i in 0..<data.count {
                        self.notificationData.append(data[i])
                    }
                    if notificationData.isEmpty{
                        self.vw_Nonotification.isHidden = false
                    }else{
                        self.vw_Nonotification.isHidden = true
                    }
                    
//                switch responseCode {
//                case 1:
//                    debugPrint("Sucess")
//
//                   // ApiService.shared.showAlert(title: "", msg: responseText ?? "")
//                case 0:
//                    ApiService.shared.showAlert(title: "", msg: responseText ?? "")
//                default:
//                    ApiService.shared.showAlert(title: "", msg: responseText ?? "" )
//                }
            }
        }
     }
   }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_Notification.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTVCell
        let dict = notificationData[indexPath.row]
        cell.lbl_Title.text = dict.title
        cell.lbl_Notification.text = dict.msg
        cell.lbl_TimeDate.text = dict.date
        cell.vw_ReadUnreadindicator.backgroundColor = .red
        cell.selectionStyle = .none
        self.tbl_Notification.reloadData()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tbl_Notification.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTVCell
        cell.vw_ReadUnreadindicator.backgroundColor = .white
    }
    
    
}
