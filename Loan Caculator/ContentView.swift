//
//  ContentView.swift
//  Loan Caculator
//
//  Created by Steve Dao on 25/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

public struct ContentView: View {
    @ObservedObject var viewModel = LoanCalculatorViewModel()
    
    public var body: some View {
        if UIDevice.isPhone {
            return AnyView(PhoneContentView(viewModel: viewModel))
        } else {
            return AnyView(PadContentView(viewModel: viewModel))
        }
    }
    
    public init() {}
}

public struct ContentView_Previews: PreviewProvider {
    
    public static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .light)
            
            ContentView().environment(\.colorScheme, .dark)
                .environment(\.locale, .init(identifier: "vi_VN"))
            
        }
    }
}

