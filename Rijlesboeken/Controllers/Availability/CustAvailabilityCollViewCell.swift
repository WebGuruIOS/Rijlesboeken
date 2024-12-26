//
//  CustAvailabilityCollViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 12/05/22.
//

import UIKit

class CustAvailabilityCollViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var img_Bgimage: UIImageView!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // img_Bgimage.tintColor = UIColor.lightGray
    }
    
}
