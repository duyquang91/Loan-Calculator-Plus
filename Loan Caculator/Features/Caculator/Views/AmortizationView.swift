//
//  AmortizationView.swift
//  Loan Caculator
//
//  Created by Steve Dao on 3/3/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import SwiftUI
import LoanCalculatorInterface

struct AmortizationView: View {
    
    let amortizations: [AmortizationModel]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center, spacing: 2) {
                    Text("month").font(.subheadline).fontWeight(.bold)
                    VStack(alignment: .center) {
                        Text("principal").font(.subheadline).fontWeight(.bold)
                    }.frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center) {
                        Text("interest").font(.subheadline).fontWeight(.bold)
                    }.frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center) {
                        Text("repayment").font(.subheadline).fontWeight(.bold)
                    }.frame(maxWidth: .infinity)
                }
                
                List {
                    ForEach(amortizations.chunked(by: 12), id: \.self) { section in
                        Section(header: Text("\((section.first?.order ?? 0 + 1) / 12 + 1) " + "of".localized + " \(self.amortizations.chunked(by: 12).count)" + " " + "years".localized).frame(maxWidth: .infinity)) {
                            ForEach(section) { model in
                                AmortizationCell(amortization: model)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .padding(.horizontal, -16)
            }
            .navigationBarTitle("amortization_table", displayMode: .inline)
            .background(Color(UIColor.systemGroupedBackground))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AmortizationView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            HStack(alignment: .center, spacing: 2) {
                Text("Month").font(.subheadline).fontWeight(.bold)
                VStack(alignment: .center) {
                    Text("Principal").font(.subheadline).fontWeight(.bold)
                }.frame(maxWidth: .infinity)
                
                VStack(alignment: .center) {
                    Text("Interest").font(.subheadline).fontWeight(.bold)
                }.frame(maxWidth: .infinity)
                
                VStack(alignment: .center) {
                    Text("Repayment").font(.subheadline).fontWeight(.bold)
                }.frame(maxWidth: .infinity)
            }
            
            List {
                ForEach(AmortizationModel.mocks.chunked(by: 12), id: \.self) { section in
                    Section(header: Text("2 of 5 years").frame(maxWidth: .infinity)) {
                        ForEach(section) { model in
                            AmortizationCell(amortization: model)
                        }
                    }
                }
            }.listRowInsets(EdgeInsets())
        }.background(Color(UIColor.systemGroupedBackground))
    }
}
