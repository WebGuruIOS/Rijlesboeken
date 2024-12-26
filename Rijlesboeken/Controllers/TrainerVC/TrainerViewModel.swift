//
//  TrainerViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 27/07/22.
//

import Foundation

class TrainerListResponse {
    static let shared = TrainerListResponse()
  public static func
  AddUserData(api:String,parameters:[String:Any],completion:@escaping(trainerDataList?)->Void){
    ApiService.shared.mobileApiRequest(api: api, method: .get, parameters: parameters) {
        (data, val, error) in
        guard let data = data else { return }
        do{
            let res = try
                JSONDecoder().decode(trainerDataList?.self, from: data)
            completion(res)
        }catch{
            completion(nil)
            debugPrint("Error on parsing")
        }
    }
  }
}

