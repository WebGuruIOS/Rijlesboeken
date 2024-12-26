//
//  PlaastenCollecCell.swift
//  Rijlesboeken
//
//  Created by Prince on 25/04/22.
//

import UIKit

class PlaastenCollecCell: UICollectionViewCell {
    
    @IBOutlet weak var vw_bg: UIView!
    @IBOutlet weak var lbl_Location: UILabel!
    @IBOutlet weak var img_Location: UIImageView!
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
        vw_bg.roundCorners(corners: [.bottomLeft, .bottomRight, .topRight], radius: 20)
    }
}
