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
    @StateObject var vm = BikeMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self)
    )
    
    
    var body: some View {
        VStack() {
            TabView {
                BikeMapView(viewModel: vm)
                    .tabItem {
                        Label("transit", systemImage: "map")
                    }.onAppear{
                        vm.getTransStations(transType: TransitType.bike)
                    }
                BikeListView()
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
