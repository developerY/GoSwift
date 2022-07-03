//
//  BikeListView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//
// SwiftUI is a subscriber to a Combine publisher
import SwiftUI
import MapKit




struct BikeInfoRow: View {
    var station: Station
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "pencil")
            Text(station.name)
            Spacer()
                .frame(maxWidth: .infinity)
                //.frame(maxWidth: .infinity)
            Text(" [\(station.capacity)]")
                //.frame(maxWidth: .infinity)
        }
    }
}

struct BikeListView: View {
    
    // Get viewmodel from DI
    @StateObject var vm = SharedBikesListViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self) //GetAllSharedBikesUseCaseProtocol
        //deleteContact: Resolver.shared.resolve(DeleteContactUseCaseProtocol.self)
    )
    
    var body: some View {
        VStack {
            NavigationStack {
                List(vm.sharedBikes) { station in
                    NavigationLink(station.name, value:station)
                }
                .listStyle(.automatic)
                .navigationTitle("Bike List")
                .navigationDestination(for: Station.self) { station in
                    //BikeInfoRow(station: station)
                    BikeListDetailMapView(station: station)
                }
            }
        }.onAppear() {
            vm.getSharedBikes()
        }
    }
    
}



struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}

struct BikeListView_Row_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BikeListView()
        }    .previewLayout(.fixed(width:300 , height:70))
    }
}

