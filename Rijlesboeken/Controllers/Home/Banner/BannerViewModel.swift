//
//  BannerViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 13/07/22.
//

import Foundation

class BannerDataResponce{
    static let shared = BannerDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(bannerDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(bannerDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}


