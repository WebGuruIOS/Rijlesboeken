//
//  UpcomingModel.swift
//  Rijlesboeken
//
//  Created by Prince on 11/08/22.
//

import Foundation
struct upcomingData: Codable {
   let responseCode: Int?
   let responseText: String?
   let responseData : [upcomingResponse]?
}

struct upcomingResponse: Codable {
  let id : Int?
  let date : String?
  let status : String?
  let userInfo: userinforData?
  let trainerInfo: trainerInforData
  let package_image : String?
  let package_type : String?
  let time : String?
  let package_type_id : Int?
}

struct userinforData: Codable {
    let  user_id : Int?
    let  first_name : String?
    let  last_name : String?
    let  email : String?
    let  status : String?
    let  age : Int?
    let  phone : String?
    let  user_type : String?
    let  image : String?
}

struct trainerInforData: Codable {
    let user_id : Int?
    let  first_name : String?
    let last_name : String?
    let email : String?
    let  status : String?
    let   phone : String?
    let   user_type : String?
    let  image : String?
    let  age : Int?
    let  location_id :Int?
    let   avgRating : Int?
    let totalRating : Int?
}
