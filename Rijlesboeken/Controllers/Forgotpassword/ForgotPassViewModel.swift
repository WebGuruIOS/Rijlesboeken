//
//  ForgotPassViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 15/07/22.
//

import Foundation

class ForgotPsdDataResponse {
    static let shared = ForgotPsdDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(forgotPsdDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(forgotPsdDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
