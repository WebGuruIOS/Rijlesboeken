//
//  PrivacyPolicyVC.swift
//  Rijlesboeken
//
//  Created by Prince on 16/05/22.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var lbl_PrivacyPolicy: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        bgView.layer.cornerRadius = 40.0
        self.privacyPolicyApi()
        
//        webView.load(NSURLRequest(url: NSURL(string: "https://en.wikipedia.org/wiki/Google")! as URL) as URLRequest)
        
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func privacyPolicyApi(){
        let parameters:[String:Any] = [:]
        TermConDataResponse.AddUserData(api: "getStaticPage/PRIVACY_POLICY", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData
                self.lbl_PrivacyPolicy.text = code?.description
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                 print("sucess")
                    DispatchQueue.main.async {
//                    let urlWeb = URL(string:page_URL ?? "")
//                    let request = URLRequest(url: urlWeb!)
//                    print("URL:",request)
//                    self.webView.load(NSURLRequest(url: NSURL(string:page_URL ?? "" )! as URL) as URLRequest)
                        
                    }
                   // UIWebView.load(request)
                
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    
}
