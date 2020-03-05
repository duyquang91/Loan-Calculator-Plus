//
//  LoanSummaryView.swift
//  Loan Caculator
//
//  Created by Steve Dao on 25/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

public struct LoanSummaryView: View {
    @ObservedObject public var viewModel: LoanCalculatorViewModel
    
    let firstColor: Color = Color(UIColor.systemBlue)
    let secondColor: Color = Color(UIColor.systemOrange)
    let lineWidth: CGFloat = 8
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            CircleChartView(firstColor: firstColor,
                            secondColor: secondColor,
                            percentage: viewModel.totalInterestPercentage,
                            lineWidth: lineWidth).frame(width: 120
                                , height: 120, alignment: .leading)
            VStack(alignment: .leading, spacing: 0) {
                Text(" " + "paid_off".localized + " ")
                    .foregroundColor(.white)
                    .font(.caption)
                    .background(firstColor)
                    .cornerRadius(4)

                Text(viewModel.totalPaidString)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(firstColor)
                
                Text(" " + "total_interest".localized + " ")
                    .foregroundColor(.white)
                    .font(.caption)
                    .background(secondColor)
                    .cornerRadius(4)

                Text(viewModel.totalInterestString)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(secondColor)
                
                Divider()
                
                if viewModel.loanMethod == 0 {
                    Text("monthly_paid").font(.caption)
                } else {
                    Text("first_month_paid").font(.caption)
                }
                
                Text(viewModel.monthyPaidString).font(.headline).fontWeight(.bold)
            }
        }
    }
}

public struct LoanSummaryView_Previews: PreviewProvider {
    public static var previews: some View {
        Group {
            LoanSummaryView(viewModel: LoanCalculatorViewModel.mockData)
            
            LoanSummaryView(viewModel: LoanCalculatorViewModel.mockData)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, .init(identifier: "vi_VN"))
        }
    }
}

