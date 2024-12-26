//
//  BookingStatusViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/03/23.
//

import Foundation

 class BookingStatusDataResponse {
     static let shared = BookingStatusDataResponse()
     public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(BookingStatusStruct?)->Void){
         ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
             (data, val, error) in
             guard let data = data else { return }
             do{
                 let res = try
                     JSONDecoder().decode(BookingStatusStruct.self, from: data)
                 completion(res)
             } catch {
                 completion(nil)
                 print("Error on parsing")
             }
         }
     }
 }

