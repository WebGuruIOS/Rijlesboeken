//
//  PackageTypeModel.swift
//  Rijlesboeken
//
//  Created by Prince on 02/08/22.
//

import Foundation

struct packageData: Codable {
   let responseCode : Int?
   let responseText : String?
   let responseData: [responseData]?
}
struct responseData: Codable {
    let id : Int?
    let name : String?
    let package_type : String?
    let no_of_lesson : Int?
    let special : Int?
    let price : Int?
    let image: String?
    let description: String?
}
