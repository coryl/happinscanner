//
//  MainViewController.swift
//  HappinScanner
//
//  Created by Cory on 2021-05-11.
//

import UIKit
import BarcodeScanner

final class MainViewController: UIViewController {
    private var scanner: ScannerAdapter = ScannerAdapter()
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "barcodeCellIdentifier"
    
    var barcodes: [Barcode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupScanner()
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showScanner()
    }
    
    private func setupScanner(){
        self.scanner.delegate = self
    }
    
    private func setupTableView(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    private func showScanner(){
        self.scanner.presentFrom(self)
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        self.showScanner()
    }
}

//MARK: ScannerAdapterDelegate implementation
extension MainViewController: ScannerAdapterDelegate {
    func scanner(didCaptureCode barcode: Barcode) {
        self.barcodes.append(barcode)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //delay required for some reason related to internal BarcodeScannerViewController implementation
            self.scanner.dismiss()
            self.tableView.reloadData()
        }
    }
    
    func scanner(didReceiveError error: Error) {
        print("did receive error")
        //TODO: Show error in alert.
    }
}

// MARK: TableView implementation
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.barcodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        let invertedRow = (self.barcodes.count - 1) - indexPath.row
        let barcode = self.barcodes[invertedRow]
        cell?.textLabel?.text = "\(barcode.code) (\(barcode.type))"
        
        return cell ?? UITableViewCell()
    }
}
