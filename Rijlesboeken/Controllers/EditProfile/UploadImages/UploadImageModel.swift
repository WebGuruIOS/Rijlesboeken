//
//  UploadImageModel.swift
//  Rijlesboeken
//
//  Created by Prince on 27/07/22.
//

import Foundation

struct uploadImgStruct: Codable {
    let responseCode: Int?
    let responseText: String?
    let responseData: uploadResponseData?
}

struct uploadResponseData: Codable {
    
}



