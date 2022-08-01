//
//  BikeListView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//
// SwiftUI is a subscriber to a Combine publisher
import SwiftUI
import MapKit


//TODO: Add Favorites with a Switch

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
    @State var seachBikeStation = ""
    @State var isEditMode: EditMode = .inactive
    @State private var searchText = ""
    
    // Get viewmodel from DI
    @StateObject var vm = SharedBikesListViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self) //GetAllSharedBikesUseCaseProtocol
        //deleteContact: Resolver.shared.resolve(DeleteContactUseCaseProtocol.self)
    )
    
    var body: some View {
        VStack {
            NavigationStack {
                List(searchResults) { station in
                    NavigationLink(station.name, value:station)
                       
                }
                .listStyle(.automatic)
                .navigationTitle("Bike Stations")
                .navigationDestination(for: Station.self) { station in
                    //BikeInfoRow(station: station)
                    BikeListDetailMapView(station: station)
                }
                .navigationBarTitle("Bike List")
                .navigationBarItems(trailing: EditButton())
                .environment(\.editMode, self.$isEditMode)
                .searchable(text: $searchText)
            }
            
            /*List {
                Section("Public Tansit") {
                    Text("Buses")
                }
                Section("Pulic Access") {
                    Text("Vans")
                }
            }*/
        }.onAppear() {
            vm.getSharedBikes()
        }
    }
    
    
    var searchResults:[Station] {
        if searchText.isEmpty {
            return vm.sharedBikeStations
        } else {
            return vm.sharedBikeStations.filter{$0.name.contains(searchText)}
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

