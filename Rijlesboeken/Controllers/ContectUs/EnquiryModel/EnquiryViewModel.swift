//
//  EnquiryViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 08/08/22.
//

import Foundation

class EnquriryDataResponce{
    static let shared = EnquriryDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(enquiryDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(enquiryDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
