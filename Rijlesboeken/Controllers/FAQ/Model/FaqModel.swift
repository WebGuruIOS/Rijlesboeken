//
//  FaqModel.swift
//  Rijlesboeken
//
//  Created by Prince on 08/08/22.
//

import Foundation

struct faqDataStruct:Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [faqResponse]?
}

struct faqResponse: Codable {
   let id : Int?
   let question : String?
   let answer : String?
}
