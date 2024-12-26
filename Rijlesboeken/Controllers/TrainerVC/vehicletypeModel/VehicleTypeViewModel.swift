//
//  VehicleTypeViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/03/23.
//

import Foundation

class VehicleDataResponse{
    static let shared = VehicleDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(vehicleDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(vehicleDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
