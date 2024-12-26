//
//  PreviousTableViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 02/09/22.
//

import UIKit

class PreviousTableViewCell: UITableViewCell {

    @IBOutlet weak var vw_Dtls_BgView: UIView!
    @IBOutlet weak var vw_Calender_BgView: UIView!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vw_Clock_BgView: UIView!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgDriver: UIImageView!
    @IBOutlet weak var lbl_Driver_Name: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var imgRating: UIImageView!
    @IBOutlet weak var lbl_Rating_Number: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Shadow.add(view: vw_Dtls_BgView, color: .lightGray)
        vw_Dtls_BgView.layer.cornerRadius = 10.0
        vw_Calender_BgView.layer.cornerRadius = 15.0
        vw_Clock_BgView.layer.cornerRadius = 15.0
        imgDriver.layer.cornerRadius = imgDriver.layer.frame.height / 2
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
