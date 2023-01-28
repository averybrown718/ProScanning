//
//  ViewController.swift
//  TextRecognition
//
//  Created by Rumeysa TAN on 12.08.2022.
//

import UIKit
import Vision
import Photos
import WeScan

class StartVC: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var modelCollection: UICollectionView!
    
    @IBOutlet weak var maskView: UIView!
    
    var scanModels: [ScanModel] = [ScanModel.init(UIImage(), "Lohnsteuer voranmelden", "10.11.2022"),
           ScanModel.init(UIImage(), "Jahresabschluss abgeben", "31.12.2022")
    ]
    
    var modelTypes = ["To Dos", "Optimierungspotentiale", "Potenzielle Risiken"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelCollection.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension StartVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scanModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return modelTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: 60)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanModelCell", for: indexPath) as! ScanModelCell
        cell.dateLbl.text = scanModels[indexPath.row].created
        cell.nameLbl.text = scanModels[indexPath.row].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ScanHeaderCell", for: indexPath) as! ScanHeaderCell
        cell.headerLbl.text = modelTypes[indexPath.section]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc2.providesPresentationContextTransitionStyle = true
        vc2.definesPresentationContext = true
        vc2.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc2.parentVC = self
        self.present(vc2, animated: true, completion: nil)

        // Make sure your vc2 background color is transparent
        maskView.isHidden = false

        vc2.view.backgroundColor = UIColor.clear
    }

}
