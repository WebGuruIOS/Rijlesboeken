//
//  Coll_VehicleTypeCell.swift
//  Rijlesboeken
//
//  Created by Prince on 15/03/23.
//

import UIKit

class Coll_VehicleTypeCell: UICollectionViewCell {

    
    @IBOutlet weak var vw_VehicleTypeBG: UIView!
    @IBOutlet weak var lbl_VehicleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw_VehicleTypeBG.layer.cornerRadius = 15//vw_VehicleTypeBG.layer.frame.height / 2
    }

}
