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
            
            /*GroupBox("Number of Bus Production by Month") {
             Chart(chartData) { production in
             BarMark(
             x: .value("Bus Production", production.count),
             y: .value("Month", production.date, unit: .month)
             )
             .foregroundStyle(by: .value("Bus Production", production.count))
             }
             .padding(.horizontal, 16)
             }
             .backgroundStyle(Color.white)*/
            GroupBox("Step Per Day") {
                Chart(healthVM.healthSteps){ step in
                    BarMark(
                        x: .value("Date",step.date),
                        y: .value("Value", step.stepCount)
                    )
                    .foregroundStyle(by: .value("Steps", step.stepCount))
                }
                .padding(.horizontal, 16)
            }
            .backgroundStyle(Color.white)
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
