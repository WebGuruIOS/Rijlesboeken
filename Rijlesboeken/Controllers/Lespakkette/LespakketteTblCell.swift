//
//  LespakketteTblCell.swift
//  Rijlesboeken
//
//  Created by Prince on 26/04/22.
//

import UIKit

class LespakketteTblCell: UITableViewCell {

    @IBOutlet weak var lbl_Packagetype: UILabel!
    @IBOutlet weak var img_Vehicle: UIImageView!
    @IBOutlet weak var vw_CellBgView: UIView!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var lbl_SpecialPrice: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var vw_vehicleTypebg: UIView!
    @IBOutlet weak var lbl_vehicleType: UILabel!
    @IBOutlet weak var lbl_Lesson: UILabel!
    @IBOutlet weak var btn_ViewDetails: UIButton!
    @IBOutlet weak var viewDetailsBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewDetailsBG.roundCorners(corners: [
            .bottomRight, .bottomLeft, .topRight]
,radius: 15)
        self.vw_vehicleTypebg.layer.cornerRadius = self.vw_vehicleTypebg.layer.frame.height / 2
        self.vw_CellBgView.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
