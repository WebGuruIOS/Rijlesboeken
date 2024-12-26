//
//  PackageViewModelss.swift
//  Rijlesboeken
//
//  Created by Prince on 24/08/22.
//

import Foundation
class PackageTypeDataResponse {
    
    static let shared = PackageTypeDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(vehicleTypeData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(vehicleTypeData.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}