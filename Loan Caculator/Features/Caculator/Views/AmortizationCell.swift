//
//  AmortizationCell.swift
//  Loan Caculator
//
//  Created by Steve Dao on 3/3/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import SwiftUI

struct AmortizationCell: View {
    
    @State var amortization: AmortizationModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("\(amortization.order)").font(.subheadline).fontWeight(.medium).frame(minWidth: 49.5)
            
            VStack {
                Text(amortization.principal.toCurrencyString())
                    .font(.subheadline)
                    .fontWeight(.medium)
            }.frame(maxWidth: .infinity)
            
            VStack {
                Text(amortization.interest.toCurrencyString())
                    .font(.subheadline)
                    .fontWeight(.medium)
            }.frame(maxWidth: .infinity)
            
            VStack {
                Text(amortization.repayment.toCurrencyString())
                    .font(.subheadline)
                    .fontWeight(.medium)
            }.frame(maxWidth: .infinity)
        }
    }
}

struct AmortizationCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack(alignment: .center, spacing: 2) {
                Text("Month").background(Color(UIColor.systemGray4))
                VStack(alignment: .center) {
                    Text("Principal")
                }.frame(maxWidth: .infinity).background(Color(UIColor.systemGray4))
                
                VStack(alignment: .center) {
                    Text("Interest")
                }.frame(maxWidth: .infinity).background(Color(UIColor.systemGray4))
                
                VStack(alignment: .center) {
                    Text("Repayment")
                }.frame(maxWidth: .infinity).background(Color(UIColor.systemGray4))
            }
            
            AmortizationCell(amortization: AmortizationModel.mock)
        }
    }
}
