//
//  RegisterModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

struct registerDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : registerDataResponse?
}
struct registerDataResponse : Codable {
    let tokenType : String?
    let token : String?
    let user : userDataResponse?
}
struct userDataResponse : Codable {
    let user_id : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let status : String?
    let age : Int?
    let phone : String?
    let user_type : String?
    let image : String?
}
