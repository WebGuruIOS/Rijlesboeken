//
//  AvailabilityViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 04/08/22.
//

import Foundation
class TimeDataResponse {
    
    static let shared = TimeDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(availableTime?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(availableTime.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
 
