//
//  UpcomingTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 10/05/22.
//

import UIKit

class UpcomingTVCell: UITableViewCell {

    @IBOutlet weak var vw_DtlsBgView: UIView!
    @IBOutlet weak var vw_CalenderBgView: UIView!
    @IBOutlet weak var img_Calender: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var vw_ClockBgView: UIView!
    @IBOutlet weak var img_Clock: UIImageView!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var img_Driver: UIImageView!
    @IBOutlet weak var lbl_DriverName: UILabel!
    @IBOutlet weak var lbl_Contact: UILabel!
    @IBOutlet weak var img_Rating: UIImageView!
    @IBOutlet weak var lbl_RatingNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Shadow.add(view: vw_DtlsBgView, color: .lightGray)
        vw_DtlsBgView.layer.cornerRadius = 10.0
        vw_CalenderBgView.layer.cornerRadius = 15.0
        vw_ClockBgView.layer.cornerRadius = 15.0
        img_Driver.layer.cornerRadius = img_Driver.layer.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
