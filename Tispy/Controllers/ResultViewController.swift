//
//  ResultViewController.swift
//  Tispy
//
//  Created by Muhammed Mustafa Geldi on 17.02.2025.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    var tip: Tip?
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set data to layout ->
        if let tip = tip {
            settingsLabel.text = "Split between \(tip.splitCount!) people, with %\(Int(tip.tipRate! * 100.0)) tip."
        }
        
        if let result = result {
            totalLabel.text = result
        }
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
