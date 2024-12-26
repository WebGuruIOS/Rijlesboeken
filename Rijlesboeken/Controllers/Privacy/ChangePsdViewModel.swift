//
//  ChangePsdViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 15/07/22.
//

import Foundation

class ChangePsdDataResponse {
    
    static let shared = ChangePsdDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(changePsdDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(changePsdDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}


