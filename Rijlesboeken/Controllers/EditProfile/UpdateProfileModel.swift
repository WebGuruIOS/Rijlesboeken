//
//  UpdateProfileModel.swift
//  Rijlesboeken
//
//  Created by Prince on 26/07/22.
//

import Foundation

struct updateProfileData: Codable {
   let responseCode: Int?
   let responseText: String?
   let responseData: profileResponse?
}

struct profileResponse: Codable {
    
}
