//
//  CircleChartView.swift
//  Loan Caculator
//
//  Created by Steve Dao on 25/2/20.
//  Copyright © 2020 Steve Dao. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public struct CircleChartView: View {
    
    private let firstColor: Color
    private let secondColor: Color
    private let percentage: Double
    private let lineWidth: CGFloat
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.addArc(center: CGPoint(x: geometry.size.height/2,
                                            y: geometry.size.height/2),
                            radius: geometry.size.height/2,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 360),
                            clockwise: false)
            }.stroke(self.firstColor, lineWidth: self.lineWidth)
            Path { path in
                path.addArc(center: CGPoint(x: geometry.size.height/2,
                                            y: geometry.size.height/2),
                            radius: geometry.size.height/2,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: -90 + 360*self.percentage),
                            clockwise: false)
            }.stroke(self.secondColor, lineWidth: self.lineWidth)
                .overlay(Text("\(self.percentage*100, specifier: "%.2f") %").font(.headline).foregroundColor(self.secondColor))
        }
    }
    
    public init(firstColor: Color,
                secondColor: Color,
                percentage: Double,
                lineWidth: CGFloat){
        
        self.percentage = percentage
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.lineWidth = lineWidth
    }
    
    public struct CircleChartView_Previews: PreviewProvider {
        public static var previews: some View {
            CircleChartView(firstColor: .blue, secondColor: .orange, percentage: 0.4567, lineWidth: 8).frame(width: 100, height: 100, alignment: .center)
        }
    }
}

