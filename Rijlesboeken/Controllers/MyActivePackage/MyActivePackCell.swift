//
//  MyActivePackCell.swift
//  Rijlesboeken
//
//  Created by Prince on 02/05/22.
//

import UIKit

class MyActivePackCell: UITableViewCell {
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var img_Vehicle: UIImageView!
    @IBOutlet weak var lbl_Package: UILabel!
    @IBOutlet weak var vw_typeBgView: UIView!
    @IBOutlet weak var lbl_remain: UILabel!
    @IBOutlet weak var lbl_remainLesson: UILabel!
    @IBOutlet weak var lbl_Validity: UILabel!
    @IBOutlet weak var lbl_validityDays: UILabel!
    @IBOutlet weak var lbl_Lessons: UILabel!
    @IBOutlet weak var img_Clock: UIImageView!
    @IBOutlet weak var img_DtlsBgView: UIImageView!
    @IBOutlet weak var btn_ViewDtls: UIButton!
    @IBOutlet weak var lbl_Auto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Shadow.add(view: cellBgView, color: .lightGray)
        cellBgView.layer.cornerRadius = 10.0
        vw_typeBgView.layer.cornerRadius = vw_typeBgView.layer.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
