//
//  BannerModel.swift
//  Rijlesboeken
//
//  Created by Prince on 13/07/22.
//

import Foundation

struct bannerDataStruct: Codable {
    let responseCode: Int?
    let responseText: String?
    let responseData: [bannerImagesData]?
}
struct bannerImagesData: Codable {
  let title : String?
  let description : String?
  let image : String?
}

