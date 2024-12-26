//
//  UpdateProfileViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 26/07/22.
//

import Foundation

class UpdateProfileResponse {
    static let shared = UpdateProfileResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(updateProfileData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(updateProfileData.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
    
}
