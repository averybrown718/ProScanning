//
//  ScanModel.swift
//  TextRecognition
//
//  Created by iOS Dev on 10/31/22.
//

import Foundation
import UIKit

class ScanModel: NSObject, NSCoding {
    let created: String
    let text: String
    let image: UIImage?
    
    let userDefaults = UserDefaults.standard
    
    enum CodingKeys: String, CodingKey {
        case created
        case text
    }
    
    init(_ image: UIImage?, _ text: String, _ created: String) {
        self.image = image
        self.text = text
        self.created = created
    }
    
    required convenience init(coder aDecoder: NSCoder) {
          let text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
          let created = aDecoder.decodeObject(forKey: "created") as? String ?? ""
          let image = Utils.loadImageFromDiskWith(fileName: created)
          self.init(image, text, created)
      }

     func encode(with aCoder: NSCoder) {
          aCoder.encode(text, forKey: "text")
          aCoder.encode(created, forKey: "created")
     }
    
    func save() {
        Utils.saveImage(imageName: self.created, image: self.image!)
        
        if let decoded  = userDefaults.data(forKey: "scanData") {
            var decodedModels = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [ScanModel] ?? []
            decodedModels.append(self)
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: decodedModels)
            userDefaults.set(encodedData, forKey: "teams")
        }
    }
    
    required init(from decoder:Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       created = try values.decode(String.self, forKey: .created)
       text = try values.decode(String.self, forKey: .text)
       image = Utils.loadImageFromDiskWith(fileName: created)
    }
}

