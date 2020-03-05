//
//  HelpsView.swift
//  Loan Caculator
//
//  Created by Steve Dao on 5/3/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import SwiftUI

struct HelpsView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("frm").font(.headline)
                    
                    Text("frm_hint")
                    
                    Divider()
                    
                    Text("rbm").font(.headline)
                    
                    Text("rbm_hint")
                    
                }.padding()
                
            }.navigationBarTitle("interest_type", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HelpsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HelpsView()

            HelpsView().environment(\.colorScheme, .dark).environment(\.locale, .init(identifier: "vi-VN"))
        }
    }
}
