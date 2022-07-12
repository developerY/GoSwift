//
//  ContentView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/15/22.
//
//  dependence injection with needle
import SwiftUI

struct ContentView: View {
    
    // @ObservedObject var sbViewModel:SharedBikeViewModel
    // Get viewmodel from DI
    @StateObject var transMapVM = TransitMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self)
    )
    
    @StateObject var calVM = CalendarViewModel()
    
    
    var body: some View {
        VStack() {
            TabView {
                TransitMapView(viewModel: transMapVM)
                    .tabItem {
                        Label("transit", systemImage: "map")
                    }.onAppear{
                        transMapVM.getTransStations(transType: TransitType.bike)
                    }
                CalendarUIView(viewModel: calVM)
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
