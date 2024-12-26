//
//  UpcomingViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 11/08/22.
//

import Foundation

class UpcomingDataResponse{
    
    static let shared = UpcomingDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(upcomingData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(upcomingData.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
