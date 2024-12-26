//
//  Global.swift
//  Rijlesboeken
//
//  Created by Prince on 27/07/22.
//

import Foundation
import AVFoundation

//var baseURL = "http://15.207.135.58/diane/public/api/" //Development Url
var baseURL = "https://app.rijlesboeken.nl/api/"       // Live Base Url

var addressStatus:String = ""

class Global: NSObject {
    class var sharedManager: Global {
        struct Static {
            static let instance = Global()
        }
        return Static.instance
    }
}

