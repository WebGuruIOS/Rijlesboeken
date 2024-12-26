//
//  FaqViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 08/08/22.
//

import Foundation

class FaqDataResponce{
    static let shared = FaqDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(faqDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(faqDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
