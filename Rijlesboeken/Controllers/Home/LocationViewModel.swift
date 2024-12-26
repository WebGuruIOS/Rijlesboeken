//
//  LocationViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 21/07/22.
//

import Foundation
class LocationDataResponse {
    static let shared = LocationDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(LocationDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(LocationDataStruct.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
