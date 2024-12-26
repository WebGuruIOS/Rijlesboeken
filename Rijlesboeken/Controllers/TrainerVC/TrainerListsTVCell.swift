//
//  TrainerListsTVCell.swift
//  Rijlesboeken
//
//  Created by Prince on 28/04/22.
//

import UIKit

class TrainerListsTVCell: UITableViewCell {
    
    @IBOutlet weak var vw_CellBgView: UIView!
    @IBOutlet weak var img_DriverDp: UIImageView!
    @IBOutlet weak var lbl_drivername: UILabel!
    @IBOutlet weak var lbl_Contact: UILabel!
    @IBOutlet weak var vw_BookBG: UIView!
    @IBOutlet weak var img_Star: UIImageView!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var btn_Book: UIButton!
    @IBOutlet weak var coll_vehicleType: UICollectionView!
    
    var lists:[packageType] = []
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        coll_vehicleType.delegate = self
        coll_vehicleType.dataSource = self
        coll_vehicleType.register(UINib(nibName: "Coll_VehicleTypeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "typeCell")
        
        Shadow.add(view: vw_CellBgView, color: .lightGray)
        self.img_DriverDp.layer.cornerRadius = self.img_DriverDp.layer.frame.height / 2
        self.vw_CellBgView.layer.cornerRadius = 10.0
        vw_BookBG.roundCorners(corners: [.topRight, .bottomRight, .bottomLeft], radius: 15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lists = []
        self.coll_vehicleType.reloadData()
    }

}

extension TrainerListsTVCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count //list[coll_vehicleType.tag].vechileName.count
      // return trainerData[coll_vehicleType.tag].pac
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.coll_vehicleType.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! Coll_VehicleTypeCell
        cell.lbl_VehicleName.text = lists[indexPath.item].name //list[coll_vehicleType.tag].vechileName[indexPath.row]
        return cell
    }
    
    
}
