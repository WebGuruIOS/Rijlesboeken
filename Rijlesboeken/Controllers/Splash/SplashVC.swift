//
//  SplashVC.swift
//  Rijlesboeken
//
//  Created by Prince on 04/05/22.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    


}
