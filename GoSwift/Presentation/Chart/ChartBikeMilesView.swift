//
//  ChartStepsView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/29/22.
//

import SwiftUI
import Charts

struct ChartBikeMilesView: View {
    @StateObject var healthVM : HealthViewModel
    
    
    var body: some View {
        VStack {
            
            Text("Your Bike Miles")
                .font(.title)
                .frame(maxWidth:.infinity)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 5)
                .background(.blue)
                .border(.cyan,width: 7)
            
            GroupBox("Bike Miles Per Day") {
                Chart(healthVM.healthBikeMiles){ bike in
                    BarMark(
                        x: .value("Date",bike.date),
                        y: .value("Value", bike.bikeMiles)
                    ).foregroundStyle(by: .value("Miles", bike.bikeMiles))
                }
                .padding(.horizontal, 16)
            }
            .backgroundStyle(Color.white)
        }
    }
}


struct ChartBikeMilesView_Previews: PreviewProvider {
    static var healthVM = HealthViewModel(
        getAllHealtInfo: Resolver.shared.resolve(GetHealthInfoUseCaseProtocol.self)
    )
    
    
    static var previews: some View {
        ChartBikeMilesView(healthVM: healthVM)
    }
}
