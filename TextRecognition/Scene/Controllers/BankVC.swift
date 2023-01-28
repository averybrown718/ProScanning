//
//  BankVC.swift
//  TextRecognition
//
//  Created by iOS Dev on 11/5/22.
//

import UIKit

class BankVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var colData = ["Assessment Basis", "Tax Rate", "Tax amount"]
    var rowData = ["Corporate Income Tax", "Capital Gains Tax", "Trade Tax", "Sales Tax", "Total"]
    var bankData = ["€ XXX", "X%", "€ XXX"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
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

extension BankVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        print("cell width: \(width)")
//        return CGSize(width: width, height: 60)
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankModelCell", for: indexPath) as! BankModelCell
        cell.firstLbl.text = rowData[indexPath.row]
        cell.secondLbl.text = bankData[0]
        cell.thirdLbl.text = bankData[1]
        cell.forthLbl.text = bankData[2]
        
        if indexPath.row == rowData.count - 1 {
            cell.firstLbl.font = UIFont(name: "IBMPlexSans-Medium", size: 14)
            cell.secondLbl.font = UIFont(name: "IBMPlexSans-Medium", size: 14)
            cell.thirdLbl.font = UIFont(name: "IBMPlexSans-Medium", size: 14)
            cell.forthLbl.font = UIFont(name: "IBMPlexSans-Medium", size: 14)
        }
        else {
            cell.firstLbl.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
            cell.secondLbl.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
            cell.thirdLbl.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
            cell.forthLbl.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BankHeaderCell", for: indexPath) as! BankHeaderCell
        cell.firstLbl.text = colData[0]
        cell.secondLbl.text = colData[1]
        cell.thirdLbl.text = colData[2]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

