//
//  OrdeModel.swift
//  Rijlesboeken
//
//  Created by Prince on 24/08/22.
//

import Foundation

struct ordersDataStr: Codable {
    let  responseCode : Int?
    let  responseText : String?
    let responseData : orderDataresponse?
}

struct orderDataresponse: Codable {
    let payment_status : String?
    let payment_mode : String?
    let order_number : String?
    let date : String?
}
