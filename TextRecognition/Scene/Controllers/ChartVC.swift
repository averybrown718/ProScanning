//
//  ChartVC.swift
//  TextRecognition
//
//  Created by iOS Dev on 11/5/22.
//

import UIKit
import PieCharts

class ChartVC: UIViewController, PieChartDelegate {
    
    @IBOutlet weak var chartCollection: UICollectionView!
    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var assetCollection: UICollectionView!
    
    var chartModel = ["Cash", "Equities", "F.I.", "High Risk"]
    var chartColors = ["39C86A", "263238", "607D8B", "2DB6F5"]
    var assetModelIcons = ["database", "equity", "income", "estate", "risk"]
    var assetModelNames = ["Cash & Equivalents", "Equities", "Fixed Income", "Real Estate", "High Risk"]
    var priceModels = ["€65,532.30", "$110,760", "$735,721", "€0.00", "€108,728"]
    var pricePercents = ["-5.8%", "-12.3%", "+ 3.0%", "0.0%", "+ 194.0%"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chartCollection.reloadData()
        assetCollection.reloadData()
    }
    
    fileprivate func createModels() -> [PieSliceModel] {
        return [
            PieSliceModel(value: 12.5, color: UIColor.hexStringToUIColor(hex: "263238", alpha: 1.0)),
            PieSliceModel(value: 12.5, color: UIColor.hexStringToUIColor(hex: "39C86A", alpha: 1.0)),
            PieSliceModel(value: 12.5, color: UIColor.hexStringToUIColor(hex: "2DB6F5", alpha: 1.0)),
            PieSliceModel(value: 62.5, color: UIColor.hexStringToUIColor(hex: "607D8B", alpha: 1.0))
        ]
    }
    
    func onSelected(slice: PieCharts.PieSlice, selected: Bool) {
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

extension ChartVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == assetCollection {
            return assetModelNames.count
        }
        else {
            return chartModel.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == assetCollection {
            let width = collectionView.frame.size.width
            return CGSize(width: width, height: 40)
        }
        else {
            let width = collectionView.frame.size.width
            return CGSize(width: width / 4 - 10, height: 40)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == assetCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! AssetCell
            cell.assetIcon.image = UIImage(named: assetModelIcons[indexPath.row])
            cell.assetName.text = assetModelNames[indexPath.row]
            cell.priceLbl.text = priceModels[indexPath.row]
            cell.percentLbl.text = pricePercents[indexPath.row]
            if indexPath.row < 2 {
                cell.percentLbl.textColor = UIColor.hexStringToUIColor(hex: "D06978", alpha: 1.0)
            }
            else if indexPath.row == 3 {
                cell.percentLbl.textColor = UIColor.hexStringToUIColor(hex: "607D8B", alpha: 1.0)
            }
            else {
                cell.percentLbl.textColor = UIColor.hexStringToUIColor(hex: "33A721", alpha: 1.0)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath) as! ChartCell
            cell.circleView.backgroundColor = UIColor.hexStringToUIColor(hex: chartColors[indexPath.row], alpha: 1.0)
            cell.assetLbl.text = chartModel[indexPath.row]
            return cell
        }
        
    }
}

