//
//  InvoiceViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 11/08/22.
//

import Foundation

class InvoiceDataResponce {
    
    static let shared = InvoiceDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(invoiceData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(invoiceData.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
