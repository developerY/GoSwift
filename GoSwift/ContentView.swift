//
//  ContentView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/24/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // @ObservedObject var sbViewModel:SharedBikeViewModel
    // Get viewmodel from DI
    @StateObject var transMapVM = TransitMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self),
        getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
    )
    
    @StateObject var calVM = CalendarViewModel(
        getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
    )
    
    
    
    var body: some View {
        VStack() {
            TabView {
                TransitMapView(viewModel: transMapVM)
                    .tabItem {
                        Label("transit", systemImage: "map")
                    }.onAppear{
                        transMapVM.getTransStations(transType: TransitType.bike)
                    }
                CalendarUIView(calVM: calVM)
                    .tabItem {
                        Label("events", systemImage: "calendar")
                    }
                BikeChartView()
                    .tabItem {
                        Label("charts", systemImage: "chart.xyaxis.line")
                    }
            }
        }
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var healthVM = HealthViewModel()
    static var previews: some View {
        Text("ToDo")
        //ContentView(healthVM: healthVM)
    }
}
