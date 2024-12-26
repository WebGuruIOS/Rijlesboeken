//
//  TrainerModel.swift
//  Rijlesboeken
//
//  Created by Prince on 27/07/22.
//

import Foundation
struct trainerDataList: Codable {
  let responseCode : Int?
  let responseText : String?
  let responseData : [trainerData]?
}

struct trainerData: Codable {
   let id : Int?
   let name : String?
   let phone : String?
   let image : String?
   let packageType: [packageType]?
   let location: [locationData]?
   let avgRating: Int?
   let totalRating: Int?
}

struct packageType: Codable {
   let id : Int?
   let name : String?
}

struct locationData: Codable {
   let id : Int?
   let name : String?
}

