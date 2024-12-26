//
//  SendOtpModel.swift
//  Rijlesboeken
//
//  Created by Prince on 14/07/22.
//

import Foundation

struct sendOtpStruct : Codable {
   let responseCode : Int?
    let responseText : String?
    let responseData : otpDataResponse?
}
struct otpDataResponse : Codable {
    let otp : Int?

}
