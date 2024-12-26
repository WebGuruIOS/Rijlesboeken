//
//  CheckReachbility.swift
//  Classefy Student
//
//  Created by Prince on 11/07/2022.
//
import AVFoundation
import UIKit
import Alamofire
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
