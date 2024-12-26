//
//  CustBookingCell.swift
//  Rijlesboeken
//
//  Created by Prince on 25/04/22.
//

import UIKit

class CustBookingCell: UICollectionViewCell {
    @IBOutlet weak var vw_TimeBgView: UIView!
    @IBOutlet weak var vw_DateBgView: UIView!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_DriverContctNum: UILabel!
    @IBOutlet weak var lbl_DriverName: UILabel!
    @IBOutlet weak var img_Dp: UIImageView!
    @IBOutlet weak var ratingImg: UIImageView!
    @IBOutlet weak var lbl_rating: UILabel!
    @IBOutlet weak var cellBgView: UIView!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        self.vw_DateBgView.layer.cornerRadius = self.vw_DateBgView.layer.frame.height / 2
        self.vw_TimeBgView.layer.cornerRadius = self.vw_TimeBgView.layer.frame.height / 2
        self.img_Dp.layer.cornerRadius = self.img_Dp.layer.frame.height / 2
        
        self.cellBgView.layer.cornerRadius = 10.0
      //  self.ratingImg.backgroundColor = .darkGray
        
        
    }
   
    
    
}
