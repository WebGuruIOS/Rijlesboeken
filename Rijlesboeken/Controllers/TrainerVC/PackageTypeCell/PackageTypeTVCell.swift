//
//  PackageTypeTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 04/08/22.
//

import UIKit

class PackageTypeTVCell: UITableViewCell {

    @IBOutlet weak var lbl_PackType: UILabel!
    
    @IBOutlet weak var img_ChechUncheck: UIImageView!
    @IBOutlet weak var btn_CheckUncheck: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn_CheckUncheck.isSelected = false
        btn_CheckUncheck.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    @IBAction func act_CheckUncheck(_ sender: Any) {
//        if btn_CheckUncheck.isSelected == true{
//            self.btn_CheckUncheck.isSelected = false
//            self.btn_CheckUncheck.tintColor = .lightGray
//        }else{
//            self.btn_CheckUncheck.isSelected = true
//            self.btn_CheckUncheck.tintColor = .orange
//           // self.vw_dropDownBgView.isHidden = true
//        }
    }
}
