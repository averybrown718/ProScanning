//
//  AssetCell.swift
//  TextRecognition
//
//  Created by iOS Dev on 11/5/22.
//

import UIKit

class AssetCell: UICollectionViewCell {
    
    
    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var assetName: UILabel!
    @IBOutlet weak var assetIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
