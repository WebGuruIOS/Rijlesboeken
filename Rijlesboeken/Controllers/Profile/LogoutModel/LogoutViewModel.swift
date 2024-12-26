//
//  LogoutViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 06/08/22.
//

import Foundation

class LogoutDataResponse {
    
    static let shared = LogoutDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(logoutDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(logoutDataStruct.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
