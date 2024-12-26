//
//  SaveBookingViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 25/08/22.
//

import Foundation
class SaveBookingDataResponse {
    
    static let shared = SaveBookingDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(saveBookingDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(saveBookingDataStruct.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
