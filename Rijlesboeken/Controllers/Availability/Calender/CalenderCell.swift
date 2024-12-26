//
//  CalenderCell.swift
//  Rijlesboeken
//
//  Created by Prince on 12/05/22.
//

import UIKit

class CalenderCell: UICollectionViewCell {
    
    @IBOutlet weak var vw_DateBgView: UIView!
    @IBOutlet weak var dayOfMonth: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.vw_DateBgView.layer.cornerRadius = self.vw_DateBgView.layer.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        vw_DateBgView?.backgroundColor = .clear
        //self.vw_DateBgView.layer.cornerRadius = self.vw_DateBgView.layer.frame.height / 2
    }
}
