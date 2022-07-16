//
//  ContentView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/15/22.
//
//  dependence injection with needle
import SwiftUI
import EventKit

class MyEvent : ObservableObject{
    @Published var eventName:String = "SF Downtown"
    @Published  var location:CLLocation = CLLocation.init(latitude: 37.22, longitude: -122.22)
}


struct ContentView: View {
    @StateObject var myEvent = MyEvent()
    
    // @ObservedObject var sbViewModel:SharedBikeViewModel
    // Get viewmodel from DI
    @StateObject var transMapVM = TransitMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self)
        //getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
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
                CalendarUIView(calVM: calVM)
                    .tabItem {
                        Label("events", systemImage: "calendar")
                    }
                BikeChartView()
                    .tabItem {
                        Label("charts", systemImage: "chart.xyaxis.line")
                    }
            }
        }.environmentObject(myEvent)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("hi")
            ContentView()
        }
    }
}
