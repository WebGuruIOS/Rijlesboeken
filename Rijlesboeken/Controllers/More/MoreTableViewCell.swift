//
//  MoreTableViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 27/04/22.


import UIKit

class MoreTableViewCell: UITableViewCell {
   
    @IBOutlet weak var bg_View: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Shadow.add(view: bg_View, color: .lightGray)
        bg_View.roundCorners(corners: [.bottomLeft, .topRight, .bottomRight], radius: 25)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
