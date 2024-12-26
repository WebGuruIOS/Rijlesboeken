//
//  MyInvoiceTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 10/05/22.
//

import UIKit

class MyInvoiceTVCell: UITableViewCell {

    @IBOutlet weak var vw_CellBgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_Vehiclename: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_PurchaseDate: UILabel!
    @IBOutlet weak var lbl_Active: UILabel!
    @IBOutlet weak var vw_TypeBgView: UIView!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var lbl_Lesson: UILabel!
    @IBOutlet weak var vw_Active: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Shadow.add(view: vw_CellBgView, color: .lightGray)
        vw_TypeBgView.layer.cornerRadius = vw_TypeBgView.layer.frame.height / 2
        
        vw_Active.layer.cornerRadius = vw_Active.layer.frame.height / 2
        vw_CellBgView.layer.cornerRadius = 10.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
