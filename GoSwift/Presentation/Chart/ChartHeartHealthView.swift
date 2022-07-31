//
//  ChartStepsView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/29/22.
//

import SwiftUI
import Charts

struct ChartHeartHealthView: View {
    var body: some View {
        VStack {
            
            Text("Heart Health")
                .font(.title)
                .frame(maxWidth:.infinity)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 5)
                .background(.blue)
                .border(.cyan,width: 7)
            
            
            
            List {
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
                .frame(height: 250)
            }
        }
    }
}

struct ChartHeartHealthView_Previews: PreviewProvider {
    static var previews: some View {
        ChartHeartHealthView()
    }
}
