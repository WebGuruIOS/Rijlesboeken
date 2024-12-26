//
//  VehicleTypeModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/03/23.
//

import Foundation

struct vehicleDataStruct: Codable {
    
   let responseCode: Int
   let responseText: String
   let responseData: [vechicleTypeDta]?
}

struct vechicleTypeDta: Codable {
    let id: Int?
    let name: String?
}
