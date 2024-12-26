//
//  ProfileTableViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 27/04/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lbl_Subtitle: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Shadow.add(view: imgBg, color: .lightGray)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
