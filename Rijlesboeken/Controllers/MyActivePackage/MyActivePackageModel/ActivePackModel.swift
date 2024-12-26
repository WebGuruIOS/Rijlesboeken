//
//  ActivePackModel.swift
//  Rijlesboeken
//
//  Created by Prince on 10/08/22.
//

import Foundation

struct activePackData:Codable {
    let responseCode: Int?
    let responseText: String?
    let responseData: [activepackData]?
}

struct activepackData:Codable {
    let id: Int?
    let remaining_lesson: Int?
    let total_lesson: Int?
    let package_type_id: Int?
    let package_type: String?
    let purchase_date: String?
    let name: String?
    let image: String?
    let price: Int?
    let offer_price: Int?
    let valid_upto: Int?
}
