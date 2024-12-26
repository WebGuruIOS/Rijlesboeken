//
//  ProfileModel.swift
//  Rijlesboeken
//
//  Created by Prince on 15/07/22.
//

import Foundation

struct profileData : Codable {
    let status : Int?
    let msg : String?
    let payload : userInfor?
    
}
struct userInfor : Codable {
    let user : userDetail?
}

struct userDetail : Codable {
    let user_id : Int?
    let first_name : String
    let last_name : String?
    let email : String?
    let status : String?
    let age : Int?
    let phone : String?
    let user_type : String?
    let image : String?
}
