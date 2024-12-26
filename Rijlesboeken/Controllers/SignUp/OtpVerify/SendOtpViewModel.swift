//
//  SendOtpViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

class OtpDataResponce{
    static let shared = OtpDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(sendOtpStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(sendOtpStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
