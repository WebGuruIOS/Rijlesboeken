//
//  ProfileViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 15/07/22.
//

import Foundation

class ProfileDataResponse {
    
    static let shared = ProfileDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(profileData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(profileData.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
 
