//
//  NotificationTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 10/08/22.
//

import UIKit

class NotificationTVCell: UITableViewCell {
    
    @IBOutlet weak var vw_CellBgView: UIView!
    @IBOutlet weak var vw_ReadUnreadindicator: UIView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Notification: UILabel!
    @IBOutlet weak var lbl_TimeDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vw_CellBgView.layer.cornerRadius = 10.0
        self.vw_ReadUnreadindicator.layer.cornerRadius = vw_ReadUnreadindicator.layer.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
