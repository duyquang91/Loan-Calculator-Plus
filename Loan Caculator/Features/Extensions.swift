//
//  Extensions.swift
//  Loan Caculator
//
//  Created by Steve Dao on 29/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import Foundation
import UIKit
import LoanCalculatorInterface

public extension String {
    func toInt() -> Int? {
        let digits = components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        return Int(digits)
    }

    func toDouble() -> Double? {
        let digits = components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        return Double(digits)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

public extension Double {
    func toCurrencyString() -> String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
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

public extension UIDevice {
    static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}

public extension Formatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}

public extension LoanMethod {
    init(fromIndex index: Int) {
        self = index == 0 ? .flat : .balanceReduce
    }
}

extension AmortizationModel {
    static var mock: AmortizationModel {
        return AmortizationModel(order: 1, principal: 150000000000000, interest: 5000000)
    }

    static var mocks: [AmortizationModel] {
        return [AmortizationModel(order: 1, principal: 15000000, interest: 5000000),
                AmortizationModel(order: 2, principal: 15000000, interest: 500000000000),
                AmortizationModel(order: 3, principal: 1500000000000, interest: 5000000),
                AmortizationModel(order: 4, principal: 15000000, interest: 5000000)]
    }
}
