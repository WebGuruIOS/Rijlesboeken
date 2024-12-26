//
//  LocationTableViewCell.swift
//  Rijlesboeken
//
//  Created by Prince on 20/07/22.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_Location: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
