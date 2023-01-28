//
//  DetailVC.swift
//  TextRecognition
//
//  Created by iOS Dev on 10/31/22.
//

import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var gradientView: GradientView!
    var parentVC: StartVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gradientView.colors = [UIColor.hexStringToUIColor(hex: "#263238", alpha: 0.84),
                               UIColor.hexStringToUIColor(hex: "#0E0E10", alpha: 0.84)
        ]
        gradientView.direction = .horizontal
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.parentVC.maskView.isHidden = true
    }
    
    @IBAction func onAccept(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onReject(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
