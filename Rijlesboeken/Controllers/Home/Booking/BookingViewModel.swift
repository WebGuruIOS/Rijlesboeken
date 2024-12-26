//
//  BookingViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 13/07/22.
//

import Foundation

class BookingDataResponse{
    static let shared = BookingDataResponse()
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(bookingDataStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters){
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(bookingDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
