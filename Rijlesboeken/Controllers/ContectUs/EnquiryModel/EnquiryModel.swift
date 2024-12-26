//
//  EnquiryModel.swift
//  Rijlesboeken
//
//  Created by Prince on 08/08/22.
//

import Foundation

struct enquiryDataStruct: Codable {
  let responseCode: Int?
  let responseText: String?
  let responseData: responseEnqrData?
}

struct responseEnqrData: Codable {
    
}
