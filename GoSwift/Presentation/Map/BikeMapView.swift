//
//  BikeMapView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//

import SwiftUI
import MapKit

struct PlaceAnnotationView: View {
    @State var showTitle = true
    var iconType : TransitType
    let station: any TransportationStation
    
    var body: some View {
        VStack(spacing: 0) {
            Text(station.name)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName:iconType.rawValue)
                .font(.title)
                .foregroundColor(.blue).opacity(0.7)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.cyan).opacity(0.7)
                .offset(x: 0, y: -5)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}




struct BikeMapView: View {
    @ObservedObject var viewModel: BikeMapViewModel
    @State var bikeStations :  [Station] = []
    
    @State private var selectedTransit : TransitType = .bike
    //let transType = ["figure.walk","bicycle","train.side.front.car"]
    
    @State private var transMapPath = NavigationPath()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749,
                                       longitude: -122.4194),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )

    
    
    var body: some View {
        HStack {
            VStack {
                
                
                NavigationStack {
                    Map(coordinateRegion: .constant(region), annotationItems: viewModel.mapMarkers) { item in
                        MapAnnotation(coordinate: item.coordinate) {
                            ZStack {
                                PlaceAnnotationView(iconType: selectedTransit, station: item.station)
                                VStack {
                                    //Text("Rent")
                                    HStack {
                                        NavigationLink(destination: BikeListDetailMapView(station: item.station as! Station)) {
                                            Text("RENT")
                                        }
                                    }
                                }.offset(x:0,y:30)
                            }.padding(.vertical,30)
                        }
                    }
                    
                    Section{
                        Picker("Mode", selection: $selectedTransit) {
                            ForEach(TransitType.allCases,id :\.self) { mode in
                                Image(systemName:mode.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: selectedTransit) { tag in
                            viewModel.getTransStations(transType: tag)
                        }
                    }
                    
                }
                //bikeSchedualPicker()
            }
        }
    }
}

struct BikeMapView_Previews: PreviewProvider {
    static var vm = BikeMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self)
    )
    
    static var previews: some View {
        BikeMapView(viewModel: vm)
    }
}
