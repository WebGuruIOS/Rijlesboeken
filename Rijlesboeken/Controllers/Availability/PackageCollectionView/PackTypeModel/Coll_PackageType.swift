//
//  Coll_PackageType.swift
//  Rijlesboeken
//
//  Created by Prince on 24/08/22.
//

import UIKit

class Coll_PackageType: UICollectionViewCell {
    
    @IBOutlet weak var vw_TypeBgView: UIView!
    @IBOutlet weak var lbl_VehicleType: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vw_TypeBgView.layer.cornerRadius = 15 //vw_TypeBgView.layer.frame.width / 2
       
        
    }
}
