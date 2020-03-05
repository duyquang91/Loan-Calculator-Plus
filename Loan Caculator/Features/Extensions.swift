//
//  Extensions.swift
//  Loan Caculator
//
//  Created by Steve Dao on 29/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import Foundation

public extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        if let number = formatter.number(from: self) {
            return Double(truncating: number)
        }else {
            return nil
        }
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

public extension Double {
    func toCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func toPercentageString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter.string(from: NSNumber(value: self)) ?? "0 %"
    }
}

public extension Array {

    func chunked(by distance: Int) -> [[Element]] {
        precondition(distance > 0, "distance must be greater than 0") // prevents infinite loop

        if self.count <= distance {
            return [self]
        } else {
            let head = [Array(self[0 ..< distance])]
            let tail = Array(self[distance ..< self.count])
            return head + tail.chunked(by: distance)
        }
    }
}
