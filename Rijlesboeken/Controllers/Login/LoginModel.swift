//
//  LoginModel.swift
//  Rijlesboeken
//
//  Created by Prince on 13/07/22.
//

import Foundation

struct LoginResponseData : Codable {
    let tokenType : String?
    let token : String?
    let user : userData?
}
struct LoginDataStruct : Codable {
   let responseCode : Int?
   let responseText : String?
   let responseData : LoginResponseData?
}
struct userData : Codable {
    let  user_id : Int?
    let  first_name : String?
    let  last_name : String?
    let  email : String?
    let  status : String?
    let  phone : String?
    let  user_type : String?
    let  image : String?
    let  age : Int?
    let  location_id : Int?
    let  avgRating : Int?
    let  totalRating : Int?
}

