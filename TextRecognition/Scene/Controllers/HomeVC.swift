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

class HomeVC: UIViewController {
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var startView: UIView!    
    @IBOutlet weak var fileView: UIView!
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var undoBtn: UIButton!
    
    
    @IBOutlet weak var maskView: UIView!
    
    var scanModels: [ScanModel] = [ScanModel.init(UIImage(), "Lohnsteuer voranmelden", "10.11.2022"),
           ScanModel.init(UIImage(), "Jahresabschluss abgeben", "31.12.2022")
    ]
    
    var modelTypes = ["To Dos", "Optimierungspotentiale", "Potenzielle Risiken"]
    
    private let recognizeImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    var imageViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl.text = "Pink Elephant Ventures GmbH"
        self.startView.isHidden = false
        self.fileView.isHidden = true
        self.bankView.isHidden = true
        self.chartView.isHidden = true
        self.undoBtn.isHidden = true

        self.checkPermissions()
        imageViewController.delegate = self
        
        let addViewTap = UITapGestureRecognizer(target: self, action: #selector(self.openCamera(_:)))
        addView.addGestureRecognizer(addViewTap)
        
        let exportViewTap = UITapGestureRecognizer(target: self, action: #selector(self.onExport(_:)))
        exportView.addGestureRecognizer(exportViewTap)
        
        recognizeText(image: recognizeImage.image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        maskView.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        recognizeImage.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 60,
                                      width: view.frame.size.width-40,
                                      height: view.frame.size.width-40)
    }
    
    @objc func openLibrary(sender: UIButton){
        self.imageViewController.sourceType = .photoLibrary
        self.present(self.imageViewController, animated: true, completion: nil)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        let scannerViewController = ImageScannerController(delegate: self)
        scannerViewController.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            scannerViewController.navigationBar.tintColor = .white
        } else {
            scannerViewController.navigationBar.tintColor = .black
        }
        
        present(scannerViewController, animated: true)
    }

    
    @IBAction func onMenu(_ sender: Any) {
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        vc2.providesPresentationContextTransitionStyle = true
        vc2.definesPresentationContext = true
        vc2.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc2.parentVC = self
        vc2.isFrom = "start"
        self.present(vc2, animated: true, completion: nil)

        // Make sure your vc2 background color is transparent
        maskView.isHidden = false

        vc2.view.backgroundColor = UIColor.clear
    }
    
    func openFileView() {
        self.titleLbl.text = "Verträge"
        self.fileView.isHidden = false
        self.startView.isHidden = true
        self.bankView.isHidden = true
        self.chartView.isHidden = true
        self.undoBtn.isHidden = false
    }
    
    func openBankView() {
        self.titleLbl.text = "Steuern"
        self.fileView.isHidden = true
        self.startView.isHidden = true
        self.bankView.isHidden = false
        self.chartView.isHidden = true
        self.undoBtn.isHidden = false
    }
    
    func openChartView() {
        self.titleLbl.text = ""
        self.fileView.isHidden = true
        self.startView.isHidden = true
        self.bankView.isHidden = true
        self.chartView.isHidden = false
        self.undoBtn.isHidden = false
    }
    
    @IBAction func onUndo(_ sender: Any) {
        self.titleLbl.text = "Pink Elephant Ventures GmbH"
        self.fileView.isHidden = true
        self.startView.isHidden = false
        self.bankView.isHidden = true
        self.chartView.isHidden = true
        self.undoBtn.isHidden = true
    }
    
    func checkPermissions(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
                
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
        }else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("Access granted to use photo library.")
        } else {
            print("We don't have access to your photos.")
        }
    }
    
    @objc func sendImage(){
        recognizeText(image: recognizeImage.image)
    }
    
    @IBAction func onExport(_ sender: Any) {
        let firstActivityItem = "Renata-tech"

        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
        
        // If you want to use an image
        let image : UIImage = UIImage(named: "logo")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func saveModel(_ text: String, _ image: UIImage) {
        let scanModel = ScanModel(image, text, Date().toStr)
        scanModel.save()
    }

    private func recognizeText(image: UIImage?) {
        
        guard let cgImage = image?.cgImage else {
            print("fatal error could not cgimage")
            return
        }
        
        //Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        //Request
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else{
                return
            }
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                self?.saveModel(text, image!)
            }
        }
        
        //Process Request
        do{
            try handler.perform([request])
        }catch{
            print(error.localizedDescription)
        }

    }
}

extension HomeVC: ImageScannerControllerDelegate {
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }

    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // The user successfully scanned an image, which is available in the ImageScannerResults
        // You are responsible for dismissing the ImageScannerController
        recognizeImage.image = results.enhancedScan?.image
//        recognizeImage.image = results.croppedScan.image
        sendImage()
        scanner.dismiss(animated: true)
    }

    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
}

extension HomeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        let scannerViewController = ImageScannerController(image: image, delegate: self)
        present(scannerViewController, animated: true)
    }
}


