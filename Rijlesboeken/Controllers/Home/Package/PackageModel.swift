//
//  PackageModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

struct packageDataStruct: Codable {
   let responseCode : Int?
   let responseText : String?
   let responseData : [packageDataResponse]?
}
struct packageDataResponse: Codable {
    let id : Int?
    let name : String?
    let package_type : String?
    let no_of_lesson : Int?
    let special : Int?
    let price : Int?
    let image : String?
}
