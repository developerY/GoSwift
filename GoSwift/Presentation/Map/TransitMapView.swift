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

struct EventLocationPinView: View {
    @State var showTitle = true
    let currentEvent : CurrentCalEvent
    
    var body: some View {
        VStack(spacing: 0) {
            Text(currentEvent.eventName)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName:"figure.arms.open")
                .font(.title)
                .foregroundColor(.red).opacity(0.7)
            
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




struct TransitMapView: View {
    @ObservedObject var viewModel: TransitMapViewModel
    @State var bikeStations :  [Station] = []
    
    @State private var selectedTransit : TransitType = .bike
    //let transType = ["figure.walk","bicycle","train.side.front.car"]
    
    @State private var transMapPath = NavigationPath()
    
    /*@State private var regionVM = MKCoordinateRegion(
     center: CLLocationCoordinate2D(latitude: viewModel.currentCalEvent.location.coordinate.longitude,
     longitude: viewModel.currentCalEvent.location.coordinate.longitude),
     latitudinalMeters: 750,
     longitudinalMeters: 750
     )*/
    
    private func regionVM() -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: viewModel.currentCalEvent.location.coordinate.latitude,
                                           longitude: viewModel.currentCalEvent.location.coordinate.longitude),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    }
    
    
    var body: some View {
        HStack {
            VStack {
                NavigationStack(path: $transMapPath) { // new in iOS 16.0+ Beta (SwiftUI 4)
                    Map(coordinateRegion: .constant(regionVM()),
                        annotationItems: viewModel.mapMarkers) { item in
                        MapAnnotation(coordinate: item.coordinate) {
                            ZStack {
                                PlaceAnnotationView(iconType: selectedTransit, station: item.station)
                                VStack {
                                    //Text("Rent")
                                    HStack {
                                        if item.station is Station {
                                            NavigationLink(destination: BikeListDetailMapView(station: item.station as! Station)) {
                                                Text("RENT")
                                            }
                                        }
                                    }
                                }.offset(x:0,y:30)
                            }.padding(.vertical,30)
                        }
                    }
                    /*
                     MapPin(coordinate: viewModel.currentCalEvent.location.coordinate.latitude, viewModel.currentCalEvent.location.coordinate.longitude)
                     */
                   
             
                    
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
                Divider()
                Text("\(viewModel.currentCalEvent.eventName)")
                    .font(.title)
                    .shadow(radius: 7)
                Divider()
            }
        }
    }
}

struct TransitMapView_Previews: PreviewProvider {
    static var vm = TransitMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self),
        getCurrentCalEvent : Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
    )
    
    static var previews: some View {
        TransitMapView(viewModel: vm)
    }
}
