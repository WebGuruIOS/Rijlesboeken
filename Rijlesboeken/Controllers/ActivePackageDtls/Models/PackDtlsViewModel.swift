//
//  PackDtlsViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 16/08/22.
//

import Foundation

class PackDtlsResponse {
    
    static let shared = PackDtlsResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(packDtlsDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(packDtlsDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
