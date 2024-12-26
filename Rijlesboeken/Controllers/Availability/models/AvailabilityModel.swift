//
//  AvailabilityModel.swift
//  Rijlesboeken
//
//  Created by Prince on 04/08/22.
//

import Foundation

struct availableTime: Codable {
 let responseCode : Int?
 let responseText : String?
 let responseData : [responseTimeData]?
}
struct responseTimeData: Codable {
    let isBooked: String?
    let time: String?
}
