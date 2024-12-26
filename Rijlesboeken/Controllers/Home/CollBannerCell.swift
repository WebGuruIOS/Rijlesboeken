//
//  CollBannerCell.swift
//  Rijlesboeken
//
//  Created by Prince on 25/04/22.
//

import UIKit
import SDWebImage
import ImageSlideshow

class CollBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_vehicleName: UILabel!
    @IBOutlet weak var lbl_vehicleBrand: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!{
        didSet{
            bannerImage.layer.cornerRadius = 10.0
        }
    }
    
    func bannerSetup(_ bannerDtls: bannerImagesData){
        self.lbl_vehicleName.text = bannerDtls.title
        self.lbl_vehicleBrand.text = bannerDtls.description
        let data = bannerDtls.image ?? ""
        
        DispatchQueue.main.async {
            self.bannerImage.sd_setImage(with: URL(string:data), placeholderImage: UIImage(named: "Car1"))
        }
    }
    


}
