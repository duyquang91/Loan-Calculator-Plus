//
//  AmortizationModel.swift
//  Loan Caculator
//
//  Created by Steve Dao on 25/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import Foundation

public struct AmortizationModel {
    
    public let order: Int
    public let principal: Double
    public let interest: Double
    public var repayment: Double {
        principal + interest
    }
}

extension AmortizationModel: Identifiable, Hashable {
    public var id: Int {
        return order
    }
    
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
