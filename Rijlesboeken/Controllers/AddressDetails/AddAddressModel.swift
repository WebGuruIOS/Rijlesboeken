//
//  AddAddressModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

struct addAddressDataStruct : Codable {
   let responseCode : Int?
   let responseText : String?
   let responseData : addressResponce?

}
struct addressResponce : Codable {
    
}
