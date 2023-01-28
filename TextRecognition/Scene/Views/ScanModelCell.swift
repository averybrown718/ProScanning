//
//  ScanModelCell.swift
//  TextRecognition
//
//  Created by iOS Dev on 10/31/22.
//

import UIKit

class ScanModelCell: UICollectionViewCell {
      
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    
    override func awakeFromNib() {
        gradientView.colors = [UIColor.hexStringToUIColor(hex: "#263238", alpha: 0.84),
                               UIColor.hexStringToUIColor(hex: "#0E0E10", alpha: 0.84)
        ]
        gradientView.direction = .horizontal
        gradientView.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        gradientView.layer.shadowOpacity = 0.25
        gradientView.layer.shadowOffset = CGSize(width: 0, height: -6)
        gradientView.layer.shadowRadius = 43
    }

}
