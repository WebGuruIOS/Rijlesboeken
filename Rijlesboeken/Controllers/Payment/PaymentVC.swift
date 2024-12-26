//
//  PaymentVC.swift
//  Rijlesboeken
//
//  Created by Prince on 19/08/22.
//

import UIKit
import WebKit

class PaymentVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var vehicle_Image = String()
    var vehicle_Name = String()
    var vehicle_Type = String()
    var price = String()
    var lessons = Int()
    var vehicleId = Int()
    var chekId = String()
    var paymentUrl = String()
    var orderAdrs = String()
    var order_Price = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: paymentUrl)!)
        webView.navigationDelegate = self
        webView.load(request)

    }
}

extension PaymentVC : UIWebViewDelegate, WKNavigationDelegate{
    
    //MARK:- WKNavigationDelegate Methods

    //Equivalent of shouldStartLoadWithRequest:
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var action: WKNavigationActionPolicy?

        defer {
            decisionHandler(action ?? .allow)
        }

        guard let url = navigationAction.request.url else { return }
        print("decidePolicyFor - url: \(url)")

        let string = url.absoluteString
                  if (string.contains("mollie-checkout")) {
                    print("Mollie Value:")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"OrderSummaryVC") as? OrderSummaryVC
                    vc?.img = vehicle_Image
                    vc?.vehi_Name = vehicle_Name
                    vc?.vehi_Type = vehicle_Type
                    vc?.vehi_ID = vehicleId
                    vc?.less = lessons
                    vc?.adrs = orderAdrs
                    vc?.price = order_Price
                    vc?.check_ID = chekId
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                   //   decisionHandler(.cancel)
                   
                      return
                  }
       
    }

    //Equivalent of webViewDidStartLoad:
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start: \(String(describing: webView.url?.description))")
    }

    //Equivalent of didFailLoadWithError:
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let nserror = error as NSError
        if nserror.code != NSURLErrorCancelled {
            webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
        }
    }
    
    //Equivalent of webViewDidFinishLoad:
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish - webView.url: \(String(describing: webView.url?.description))")
    }
}

