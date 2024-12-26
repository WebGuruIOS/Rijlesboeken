//
//  ContectModel.swift
//  Rijlesboeken
//
//  Created by Prince on 08/08/22.
//

import Foundation
struct contectInfoDataStruct: Codable {
   let responseCode: Int?
   let responseText: String?
   let responseData: [contectData]?
}

struct contectData: Codable {
    let id : Int?
    let address : String?
    let phone: String?
    let email: String?
    let contact_hour: String?
}
              
        
