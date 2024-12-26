//
//  RegisterViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

class RegisterDataResponce{
    static let shared = RegisterDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(registerDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(registerDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
