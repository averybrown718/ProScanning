//
//  SideMenuVC.swift
//  TextRecognition
//
//  Created by iOS Dev on 11/4/22.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var fileView: UIView!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var chartView: UIView!

    var parentVC: HomeVC!
    var isFrom: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let tapFile = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFile(_:)))
        self.fileView.addGestureRecognizer(tapFile)
        
        let tapBank = UITapGestureRecognizer(target: self, action: #selector(self.handleTapBank(_:)))
        self.bankView.addGestureRecognizer(tapBank)
        
        let tapChart = UITapGestureRecognizer(target: self, action: #selector(self.handleTapChart(_:)))
        self.chartView.addGestureRecognizer(tapChart)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.parentVC.maskView.isHidden = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.dismiss(animated: true)
    }
    
    @objc func handleTapFile(_ sender: UITapGestureRecognizer? = nil) {
        tapFile()
    }
    
    @objc func handleTapBank(_ sender: UITapGestureRecognizer? = nil) {
        tapBank()
    }
    
    @objc func handleTapChart(_ sender: UITapGestureRecognizer? = nil) {
        tapChart()
    }
    
    func tapBank() {
        self.dismiss(animated: true) {
            if self.isFrom != "bank" {
                self.parentVC.openBankView()
            }
            else if self.isFrom == "bank" {
                self.dismiss(animated: true)
            }
        }
    }
    
    func tapChart() {
        self.dismiss(animated: true) {
            if self.isFrom != "chart" {
                self.parentVC.openChartView()
            }
            else if self.isFrom == "chart" {
                self.dismiss(animated: true)
            }
        }
    }
    
    func tapFile() {
        self.dismiss(animated: true) {
            if self.isFrom != "file" {
                self.parentVC.openFileView()
            }
            else if self.isFrom == "file" {
                self.dismiss(animated: true)
            }
        }
    }

    @IBAction func onTapFile(_ sender: Any) {
        tapFile()
    }
    
    @IBAction func onTapBank(_ sender: Any) {
        tapBank()
    }
    
    
    @IBAction func onTapChart(_ sender: Any) {
        tapChart()
    }
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
                self.dismiss(animated: true)
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
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
