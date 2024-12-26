//
//  ChangePsdModel.swift
//  Rijlesboeken
//
//  Created by Prince on 15/07/22.
//

import Foundation

struct changePsdDataStruct: Codable {
    let responseCode: Int?
    let responseText: String?
    let responseData: changedDataresponse?
}
struct changedDataresponse:Codable {
    
}
