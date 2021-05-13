//
//  ScannerAdapter.swift
//  HappinScanner
//
//  Created by Cory on 2021-05-12.
//

import Foundation
import BarcodeScanner

protocol ScannerAdapterDelegate {
    func scanner(didCaptureCode barcode: Barcode)
    func scanner(didReceiveError error: Error)
}

class ScannerAdapter {
    private var barcodeScanner: BarcodeScannerViewController
    var delegate: ScannerAdapterDelegate?
    
    init() {
        self.barcodeScanner = BarcodeScannerViewController()
        self.barcodeScanner.codeDelegate = self
        self.barcodeScanner.dismissalDelegate = self
        self.barcodeScanner.errorDelegate = self
    }
    
    func presentFrom(_ viewController: UIViewController){
        viewController.present(self.barcodeScanner, animated: false, completion: nil)
    }
    
    func dismiss(){
        self.barcodeScanner.reset()
        self.barcodeScanner.dismiss(animated: true, completion: nil)
    }
}

//MARK: BarcodeScannerDelegate code
extension ScannerAdapter: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        let barcode = Barcode(code: code, type: type)
        self.delegate?.scanner(didCaptureCode: barcode)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        self.delegate?.scanner(didReceiveError: error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        //Do nothing, only needed if BarcodeScannerViewController displayed in navigationBar stack.
    }
}
