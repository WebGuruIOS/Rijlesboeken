//
//  NotificationModel.swift
//  Rijlesboeken
//
//  Created by Prince on 10/08/22.
//

import Foundation
struct notificationDataStruct: Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [notificationData]?
}

struct notificationData: Codable {
   let id : String?
   let title : String?
   let msg : String?
   let date : String?
   let isRead : Bool?
}
