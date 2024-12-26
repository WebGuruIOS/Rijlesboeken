//
//  PackageViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

class PackageDataResponse{
    static let shared = PackageDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(packageDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters){
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(packageDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
