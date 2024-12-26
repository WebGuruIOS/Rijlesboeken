//
//  PackageModel1.swift
//  Rijlesboeken
//
//  Created by Prince on 24/08/22.
//

import Foundation
struct vehicleTypeData: Codable {
   let responseCode : Int?
   let responseText : String?
   let responseData : [typeresponse]?
}
struct typeresponse: Codable {
   let id : Int?
   let name : String?
}
