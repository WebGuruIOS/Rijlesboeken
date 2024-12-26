//
//  PackageTypeViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 02/08/22.
//

import Foundation

class packageDataValue {
    static let shared = packageDataValue()
   public static func
   AddUserData(api:String,parameters:[String:Any],completion:@escaping(packageData?)->Void){
    ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
        (data, val, error) in
        guard let data = data else { return }
        do{
            let res = try
                JSONDecoder().decode(packageData.self, from: data)
            completion(res)
        } catch {
            completion(nil)
            print("Error on parsing")
        }
     }
  }
}

