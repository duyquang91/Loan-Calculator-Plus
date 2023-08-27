//
//  LoanCalculatorViewModel.swift
//  Loan Caculator
//
//  Created by Steve Dao on 25/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import Foundation
import Combine
import LoanCalculatorInterface
import DyLibRuntimeLoader

public class LoanCalculatorViewModel: ObservableObject {
    // Inputs
    @Published public var amountString = ""
    @Published public var interestString = ""
    @Published public var termString = ""
    @Published public var termType = 0
    @Published public var loanMethod = 0
    
    // Outputs
    @Published public var totalPaidString = ""
    @Published public var totalInterestString = ""
    @Published public var totalInterestPercentage: Double = 0
    @Published public var monthyPaidString = ""
    @Published public var amortizations = [AmortizationModel]()
    @Published public var amountErrorString = ""
    @Published public var termErrorString = ""
    @Published public var interestErrorString = ""
    @Published public var isInputsValid = false
    
    private var disposeBag = Set<AnyCancellable>()
    
    public init() {
        // Dynamic load the binary
        let loanCalculator = try! dyLibLoad(withSymbol: "loan_calculator",
                                            fromFramework: .framework(name: "LoanCalculatorImplementation", directory: Directory.frameworks),
                                            forType: LoanCalculatorInterface.self)

        // Input validations
        $amountString.map { $0.isEmpty || $0.toDouble() != nil ? "" : "invalid_input".localized }
            .assign(to: \.amountErrorString, on: self)
            .store(in: &disposeBag)
        
        $termString.sink { text in
            guard !text.isEmpty else { self.termErrorString = ""; return }
            guard let number = text.toDouble() else { self.termErrorString = "invalid_input".localized; return }
            
            self.termErrorString = number == 0 ? "invalid_term".localized : ""
        }.store(in: &disposeBag)
        
        $interestString.map { text -> String in
            guard !text.isEmpty else { return "" }
            if let double = text.toDouble() {
                if double >= 0 && double <= 100 {
                    return ""
                } else {
                    return "invalid_interest".localized
                }
            } else {
                return "invalid_input".localized
            }
        }
        .assign(to: \.interestErrorString, on: self)
        .store(in: &disposeBag)
        
        // Calculations
        Publishers.CombineLatest4($amountString, $interestString, $termString, $termType.combineLatest($loanMethod))
            .sink { [weak self] tuple in
                guard let weakSelf = self,
                      let amount = tuple.0.toDouble(),
                      let interest = tuple.1.toDouble(),
                      let term = tuple.2.toInt(),
                      interest >= 0 && interest <= 100 && term > 0 else { self?.isInputsValid = false; return }

                weakSelf.isInputsValid = true
                weakSelf.amortizations.removeAll()

                let months: Int = tuple.3.0 == 0 ? term * 12 : term
                let result = loanCalculator.calculatorLoan(byAmount: amount, interest: interest, months: months, method: .init(fromIndex: tuple.3.1))

                weakSelf.totalPaidString = result.totalPaid.toCurrencyString()
                weakSelf.totalInterestString = result.totalInterest.toCurrencyString()
                weakSelf.totalInterestPercentage = result.totalInterestPercetage
                weakSelf.monthyPaidString = result.monthlyPayment?.toCurrencyString() ?? result.amortizations.first!.repayment.toCurrencyString()
                weakSelf.amortizations = result.amortizations
            }
            .store(in: &disposeBag)
    }
}

extension LoanCalculatorViewModel {
    public static var mockData: LoanCalculatorViewModel {
        let mock = LoanCalculatorViewModel()
        mock.amountString = "10000000"
        mock.interestString = "12"
        mock.termString = "4"
        
        return mock
    }
}
