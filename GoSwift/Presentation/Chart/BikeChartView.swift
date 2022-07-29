//
//  BikeChartView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//

import SwiftUI
import Charts



struct ChartValues: Identifiable {
    var name: String
    var value: Double
    var color: Color
    var id = UUID() /// :String {name}
}

struct BikeChartView: View {
    @StateObject var healthVM : HealthViewModel
    
    // The only copy.  Pass if needed
    @StateObject var vm = BikeChartViewModel()
    
    let timer =  Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var bikeChartValues: [ChartValues] =
    [
        .init(name:"Carbon Used", value:20, color: .red),
        .init(name:"Miles", value:200, color: .blue),
        .init(name:"Money Saved", value:400, color: .green),
    ]
    
    var body: some View {
        VStack {
            ZStack {
            
                Chart{
                    BarMark(x: .value("Bike Info", "Steps"),
                            y: .value("Value", healthVM.totalHealthSteps)) // published data
                    // FIXME: Place holder data still need to build
                    ForEach(bikeChartValues) {
                        (chart) in
                        BarMark(x:.value("Bike Info", chart.name),
                                y:.value("Bike Info", chart.value))
                        .foregroundStyle(chart.color)
                        
                        
                        /*LineMark(x:.value("Bike Info", chart.name),
                         y:.value("Bike Info", chart.value))
                         .foregroundStyle(chart.color)*/
                    }
                }.padding()
                
                
                VStack {
                    Gauge(value:vm.motion, in: 0...100){
                        Text("   Daily Motion  ")
                    }//.onReceive(timer){_ in withAnimation(amount += amount)}
                    
                    .padding([.top], 40)
                    .scaleEffect(3)
                    .gaugeStyle(.accessoryCircular).tint(.cyan)
                    .shadow(radius: 5)
                    
                    Spacer()
                }
            }.onAppear() {
                vm.runRandom()
                healthVM.getTotalSteps()
            }
        }
    }
}

struct BikeChartView_Previews: PreviewProvider {
    static var healthVM = HealthViewModel(
        getAllHealtInfo: Resolver.shared.resolve(GetHealthInfoUseCaseProtocol.self)
    )
    static var previews: some View {
        BikeChartView(healthVM: healthVM)
    }
}
