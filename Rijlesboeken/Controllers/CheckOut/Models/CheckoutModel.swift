//
//  CheckoutModel.swift
//  Rijlesboeken
//
//  Created by Prince on 23/08/22.
//

import Foundation

struct checkDataStruct: Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : checkoudtData?
}

struct checkoudtData: Codable {
    let  resource : String?
    let  id : String?
    let  mode : String?
    let  createdAt : String?
    let  amount : amountData?
    let  description : String?
 //   let  method : null
  //  let  metadata : null
    let  status : String?
    let  isCancelable : Bool
    let  expiresAt : String?
    let  profileId : String?
    let  sequenceType : String?
    let  redirectUrl : String?
    let _links : paymentLinks?
}
struct amountData: Codable {
    let value : String?
    let currency : String?
}

struct paymentLinks: Codable {
   // let  self : selfData?
    let  checkout : datacheckout?
    let  dashboard : datadashboard?
    let  documentation : datadocumentation?
}
//struct selfData : Codable {
//    let href : String?
//    let type : String?
//}
struct datacheckout : Codable {
    let href : String?
    let type : String?
}
struct datadashboard : Codable {
    let href : String?
    let type : String?
}
struct datadocumentation : Codable {
    let href : String?
    let type : String?
}
