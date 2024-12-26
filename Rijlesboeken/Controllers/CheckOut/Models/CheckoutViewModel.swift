//
//  CheckoutViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 23/08/22.
//

import Foundation

class CheckOutDataResponse {
    
    static let shared = CheckOutDataResponse ()
    
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(checkDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(checkDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
