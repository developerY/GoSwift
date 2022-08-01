//
//  ChartStepsView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/29/22.
//

import SwiftUI
import Charts

struct ChartStepsView: View {
    @StateObject var healthVM : HealthViewModel
    
    var body: some View {
        VStack {
            
            Text("Your Step Count")
                .font(.title)
                .frame(maxWidth:.infinity)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 5)
                .background(.blue)
                .border(.cyan,width: 7)
            
                Chart {
                    ForEach(healthVM.healthSteps){ step in
                          BarMark(
                            x: .value("Date",step.date),
                            y: .value("Value", step.stepCount)
                        )
                    }
                }
            }
        }
    
}

struct ChartStepsView_Previews: PreviewProvider {
    static var healthVM = HealthViewModel(
        getAllHealtInfo: Resolver.shared.resolve(GetHealthInfoUseCaseProtocol.self)
    )
    
    
    static var previews: some View {
        ChartStepsView(healthVM: healthVM)
    }
}
