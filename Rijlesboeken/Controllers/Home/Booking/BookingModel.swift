//
//  BookingModel.swift
//  Rijlesboeken
//
//  Created by Prince on 13/07/22.
//

import Foundation

struct bookingDataStruct: Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [bookingResponseData]?
}

struct bookingResponseData : Codable {
    let  id : Int?
    let  date : String?
    let  status : String?
    let  userInfo : userinfoData?
    let  trainerInfo : trainerinfoData?
    let  package_image : String?
    let  package_type : String?
    let  time : String?
    let  package_type_id : Int?
}
struct userinfoData:Codable {
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

struct trainerinfoData :Codable {
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
