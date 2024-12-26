//
//  TabBarVC.swift
//  Rijlesboeken
//
//  Created by Prince on 04/05/22.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
            if selectedIndex == 3 && UserDefaults.standard.string(forKey: "user_id") == nil {
                logInDtls()
                return false
            }
            return true
        }
         
    func logInDtls(){
        let alertController = UIAlertController(title: "Login Require", message: "You have not login yet. Please login.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default){ (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
    
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
   
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//       navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    

   

}
