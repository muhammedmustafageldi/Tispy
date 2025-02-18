//
//  TipBrain.swift
//  Tispy
//
//  Created by Muhammed Mustafa Geldi on 17.02.2025.
//

import Foundation

struct TipBrain {
    
    private var peymentPerPerson: String?
    
    func getPeymentPerPerson() -> String? {
        return peymentPerPerson
    }
    
    mutating func calculatePeymentPerPerson(tip: Tip) {
        let amount = tip.amount!
        let splitCount = tip.splitCount!
        let rate = tip.tipRate!
        
        // Calculate and set variable
        let result = (amount + (amount * rate)) / Double(splitCount)
        peymentPerPerson = String(format: "%.2f", result)
    }
    
}
