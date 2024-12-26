//
//  UploadImageViewModel.swift
//  Rijlesboeken
//
//  Created by Prince on 27/07/22.
//

import Foundation

class UploadImgResponse{
    
 static let shared = UploadImgResponse()
    
    public static func AddUserData(api:String,parameters:[String:Any],completion:@escaping(uploadImgStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) {
            (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try
                    JSONDecoder().decode(uploadImgStruct.self, from: data)
                completion(res)
            } catch {
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
