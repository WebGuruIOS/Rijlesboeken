//
//  LocationModel.swift
//  Rijlesboeken
//
//  Created by Prince on 21/07/22.
//

import Foundation

struct LocationDataStruct: Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [locationResponseData]?
}

struct locationResponseData : Codable {
   let id : Int?
   let name : String?
}
