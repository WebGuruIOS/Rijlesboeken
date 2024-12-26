//
//  LogoutModel.swift
//  Rijlesboeken
//
//  Created by Prince on 06/08/22.
//

import Foundation

struct logoutDataStruct: Codable{
    let responseCode: Int?
    let responseText: String?
    let responseData: logoutRespondeData?
}
 
struct logoutRespondeData: Codable{
    
}
