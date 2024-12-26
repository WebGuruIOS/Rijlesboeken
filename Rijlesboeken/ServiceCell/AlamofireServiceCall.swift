//
//  AlamofireServiceCall.swift
//  Rijlesboeken
//  Created by Prince 11/07/22.


import Foundation
import AVFoundation
import UIKit
import Alamofire
import SVProgressHUD

class ApiService {
    
    static let shared = ApiService()
    
    //var baseURL = "http://15.207.135.58/diane/public/api/" // Development Base Url
    var baseURL = "https://app.rijlesboeken.nl/api/" // Live Base Url
    var token = UserDefaults.standard.value(forKey: "Token")
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let topController = UIApplication.shared.windows[0].rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func mobileApiRequest(api: String,method:HTTPMethod,parameters:[String:Any],completion: @escaping(Data?,Any?,Error?)->Void) {
         if Reachability.isConnectedToNetwork(){
             ACProgressHUD.shared.showHUD()
             let baseUrl1 = baseURL
             guard let url = URL(string: baseUrl1 + api) else {
                 completion(nil, nil, nil)
                 return
             }
             debugPrint("Complete_Url",url)
             debugPrint("ApiName", api)
             debugPrint(parameters)
             debugPrint("CompleteUrl:",url)
             token = UserDefaults.standard.value(forKey: "Token")
             var header:HTTPHeaders = [:]
             header["contentType"] = "application/json"
             header = ["Authorization": "Bearer \(token ?? "")"]
             print("HeaderValue:",header)
             Alamofire.request(url, method: method, parameters: parameters,encoding: URLEncoding.default,headers: header).responseJSON(completionHandler: { (response) in
                 debugPrint(response)
                 ACProgressHUD.shared.hideHUD()
                 let code = response.response?.statusCode
                 if code == 0 {
                     self.showAlert(title: "error\(code ?? 0)", msg: "Something went wrong")
                 }
                 switch(response.result) {
                 case .success(_):
                     if let data = response.data{
                         completion(data,response.value, response.error)
                     }
                     break
                 case .failure(_):
                     completion(nil, nil, response.error)
                     debugPrint("error on service call1",
                     response.error?.localizedDescription as Any)
                     break
                 }
             })
             
         }else{
             ApiService.shared.showAlert(title: "Internet Alert!", msg: "Opps! No internet connection!")
         }
    }
}
