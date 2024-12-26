//
//  PlaastenTableViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 26/04/22.
//

import UIKit

class PlaastenTableViewCell: UITableViewCell {

    @IBOutlet weak var vw_BgView: UIView!
    
    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var lbl_location: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw_BgView.roundCorners(corners: [.bottomLeft, .topRight, .bottomRight], radius: 25)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
