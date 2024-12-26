//
//  ActivePackViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 10/08/22.
//

import Foundation

class ActivePackResponse{
    static let shared = ActivePackResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(activePackData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(activePackData.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
