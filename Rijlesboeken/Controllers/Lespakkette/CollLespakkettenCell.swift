//
//  CollLespakkettenCell.swift
//  Rijlesboeken
//
//  Created by Prince on 25/04/22.
//

import UIKit

class CollLespakkettenCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_PackkettenCar: UILabel!
    @IBOutlet weak var vw_CellBgView: UIView!
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vw_typeBgView: UIView!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Lessons: UILabel!
    @IBOutlet weak var lbl_SpecialPrice: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var more_BgView: UIView!
    @IBOutlet weak var btn_More: UIButton!
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
        
        Shadow.add(view: vw_CellBgView, color: .lightGray)
        
        self.more_BgView.layer.cornerRadius = self.more_BgView.layer.frame.width / 2
        self.vw_CellBgView.layer.cornerRadius = 10.0
        self.vw_CellBgView.layer.borderWidth = 1.0
        self.vw_CellBgView.layer.borderColor = UIColor.black.cgColor
        self.vw_typeBgView.layer.cornerRadius = self.vw_typeBgView.layer.frame.height / 2
    }
    
}
