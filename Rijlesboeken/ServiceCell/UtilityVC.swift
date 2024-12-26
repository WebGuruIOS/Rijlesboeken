
//  UtilityVC.swift
//  Rijlesboeken
//  Created by Prince on 11/07/22.

import UIKit
import SystemConfiguration
import Foundation

class UtilityVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension UIViewController{
    
    
    func isValid(testStr:String) -> Bool {
        guard testStr.count > 2, testStr.count < 18 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
     func isValidEmail(email: String) -> Bool {
             let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
             let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             return emailTest.evaluate(with: email)
         }
     
     /*
      Phone Number Validation
      */
//     func isValidPhone(phone: String) -> Bool {
//             let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,9}$"
//             let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//             return phoneTest.evaluate(with: phone)
//        }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,10}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
     
     /*
       Pincode Validation
      */
     
     func isValidPincode(value: String) -> Bool {
         if value.count == 6{
           return true
         }
         else{
           return false
         }
     }
     /*
       Password Validation : Check current and Confirm is Same.
      */
     func isPasswordSame(password: String , confirmPassword : String) -> Bool {
         if password == confirmPassword{
           return true
         }else{
           return false
         }
     }
     
     /*
        Password length Validation - Length should grater than 7.
      */
     func isPwdLenth(password: String , confirmPassword : String) -> Bool {
             if password.count <= 7 && confirmPassword.count <= 7{
                return true
             }else{
                return false
             }
         }
    
    func alertDisplay(titleMsg: String, displayMessage:String , buttonLabel: String) {
        let alert = UIAlertController(title: titleMsg, message: displayMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    //MARK: - Toast message design -
    //TO show a toast message
    func showToast(message : String, font: UIFont) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 130, y: self.view.frame.size.height - 170, width: 250, height: 35))
            toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.75)
            toastLabel.textColor = UIColor.black
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}


extension UIView{
    
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
        //multiple corners using CACornerMask
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
    
}


class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path){
            try! FileManager.default.removeItem(at: destinationUrl)
        }
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if error == nil
            {
                if let response = response as? HTTPURLResponse
                {
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            {
                                completion(destinationUrl.path, error)
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                        else
                        {
                            completion(destinationUrl.path, error)
                        }
                    }
                }
            }
            else
            {
                completion(destinationUrl.path, error)
            }
        })
        task.resume()
    }
}
