//
//  Term&ConditionsVC.swift
//  Rijlesboeken
//
//  Created by Prince on 16/05/22.
//

import UIKit
import WebKit

class TermConditionsVC: UIViewController {
    
    @IBOutlet weak var lbl_TermCondition: UILabel!
    
    @IBOutlet weak var view_BgView: UIView!{
        didSet{
            view_BgView.layer.cornerRadius = 40.0
        }
    }
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        webView.backgroundColor = .clear
//        webView.load(NSURLRequest(url: NSURL(string: "https://webguruz.in/")! as URL) as URLRequest)
        self.termConditionApi()
}
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func termConditionApi(){
     
        let parameters:[String:Any] = [:]
        TermConDataResponse.AddUserData(api: "getStaticPage/TERMS_AND_CONDITIONS", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData
                self.lbl_TermCondition.text = code?.description
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                 print("sucess")
                    DispatchQueue.main.async {
                   // let urlWeb = URL(string:page_URL ?? "")
                   // let request = URLRequest(url: urlWeb!)
                   // print("URL:",request)
//                    self.webView.load(NSURLRequest(url: NSURL(string:page_URL ?? "" )! as URL) as URLRequest)
//                        self.lbl_TermCondition.text = page_URL?.description
                    }
                   // UIWebView.load(request)
                
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "" )
                }
            }
        }
    }
    
}
