//
//  FaqTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 11/03/23.
//

import UIKit

class FaqTVCell: UITableViewCell {

    @IBOutlet weak var lbl_Question: UILabel!
    @IBOutlet weak var btn_Plus: UIButton!
    @IBOutlet weak var lbl_Answer: UILabel!
    @IBOutlet weak var vw_Question: UIView!
    
    @IBOutlet weak var img_Plus: UIImageView!
    @IBOutlet weak var img_minus: UIImageView!
    @IBOutlet weak var vw_Answer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Shadow.add(view: vw_Question, color: .lightGray)    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
