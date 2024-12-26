//
//  TermConditionViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 09/08/22.
//

import Foundation

class TermConDataResponse{
    
    static let shared = TermConDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(termConditionData?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(termConditionData.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
