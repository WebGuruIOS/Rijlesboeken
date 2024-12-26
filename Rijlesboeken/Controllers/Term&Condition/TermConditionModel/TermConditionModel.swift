//
//  TermConditionModel.swift
//  Rijlesboeken
//
//  Created by Prince on 09/08/22.
//

import Foundation

struct termConditionData: Codable {
    let responseCode: Int?
    let responseText: String?
    let responseData: termresponseData?
        
}

struct termresponseData:Codable {
    let id: Int?
    let description: String?
}
