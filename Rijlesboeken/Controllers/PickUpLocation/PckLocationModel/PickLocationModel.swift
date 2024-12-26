//
//  PickLocationModel.swift
//  Rijlesboeken
//
//  Created by Prince on 11/08/22.
//

import Foundation
struct pickLocationData: Codable {
    let status: Int?
    let msg: String?
    let payload: [addressData]?
}

struct addressData:Codable {
    let id: Int?
    let type: String?
    let location_id: Int?
    let locationName: String?
    let zip_code:Int?
    let house_number:String?
    let address:String?
    let mobile:String?
}
     
