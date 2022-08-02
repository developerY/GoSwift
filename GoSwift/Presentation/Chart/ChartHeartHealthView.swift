//
//  ChartStepsView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/29/22.
//

import SwiftUI
import Charts

struct ChartHeartHealthView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Heart Health")
                    .font(.title)
                    .frame(maxWidth:.infinity)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 5)
                    .background(.blue)
                    .border(.cyan,width: 7)
                
                ZStack {
                    Chart {
                        BarMark(
                            x: .value("Mount", "jan/22"),
                            y: .value("Value", 5)
                        )
                        BarMark(
                            x: .value("Mount", "fev/22"),
                            y: .value("Value", 4)
                        )
                        BarMark(
                            x: .value("Mount", "mar/22"),
                            y: .value("Value", 7)
                        )
                    }
                    .opacity(0.2)
                
                    
                    
                    
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        //.foregroundColor(.cyan)
                        .scaleEffect(animationAmount)
                        .animation(
                            .linear(duration: 0.1)
                            .delay(0.2)
                            .repeatForever(autoreverses: true),
                            value: animationAmount)
                        .foregroundStyle(
                                .linearGradient(
                                    colors: [.red, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                        .onAppear {
                            animationAmount = 1.2
                        }
                    
                }
            }
        }
    }
}

struct ChartHeartHealthView_Previews: PreviewProvider {
    static var previews: some View {
        ChartHeartHealthView()
    }
}
