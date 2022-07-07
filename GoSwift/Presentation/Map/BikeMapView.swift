//
//  BikeMapView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//

import SwiftUI
import MapKit

struct typeTransView : View {
    var vm : BikeMapViewModel
    
    @State private var selectedTransitIcon = Image(systemName: "car")
    let transTypeIcon = [
        Image(systemName: "figure.walk"),
        Image(systemName: "bike"),
        Image(systemName: "train.side.front.car"),
    ]
    
    @State private var selectedTransit = "bike"
    let transType = ["walk","bike","train"]
    
    var body: some View {
        
        
        Section{
            Picker("Mode", selection: $selectedTransit) {
                ForEach(transType,id :\.self) { mode in
                    Text("\(mode)").font(.title)
                }
            }
            .pickerStyle(.segmented)
            .onReceive([self.selectedTransit].publisher.first()) { (value) in
                //mapBikeMarkers = vm.mapMarkers
            }
            //Slider(value: $value)
            //vm.updateStations(selectedTransit.rawValue)
            
            
        }
    }
    
}

struct PlaceAnnotationView: View {
    @State var showTitle = true
    var iconType : String
    
    
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName:iconType)
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
    
    @State var mapBikeMarkers :  [MapAnnotationItem] = []
    @State var bikeStations :  [Station] = []
    @State var iconTravel : String = "bicycle.circle"
    
    //@ObservedObject var sbViewModel:SharedBikeViewModel
    // Get viewmodel from DI
    @StateObject var vm = BikeMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self) //GetAllSharedBikesUseCaseProtocol
        //deleteContact: Resolver.shared.resolve(DeleteContactUseCaseProtocol.self)
    )
    
    func getBikeStations() {
        vm.getSharedBikes()
        bikeStations = vm.sharedBikeStations
        mapBikeMarkers = vm.mapMarkers
    }
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749,
                                       longitude: -122.4194),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    
    
    @State private var selectedTransitIcon = Image(systemName: "car")
    let transTypeIcon = [
        Image(systemName: "figure.walk"),
        Image(systemName: "bike"),
        Image(systemName: "train.side.front.car"),
    ]
    
    @State private var selectedTransit = "bike"
    let transType = ["walk","bike","train"]
    
    
    var body: some View {
        HStack {
            VStack {
                Map(coordinateRegion: $region, annotationItems: mapBikeMarkers) { item in
                    //MapMarker(coordinate: item.coordinate)
                    MapAnnotation(coordinate: item.coordinate) {
                        PlaceAnnotationView(iconType: iconTravel, title: item.stationName)
                    }
                }
                //bikeSchedualPicker()
                
                Section{
                    Picker("Mode", selection: $selectedTransit) {
                        ForEach(transType,id :\.self) { mode in
                            Text("\(mode)").font(.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onReceive([self.selectedTransit].publisher.first()) { (value) in
                        
                        /*Image(systemName: "figure.walk"),
                         Image(systemName: "bike"),
                         Image(systemName: "train.side.front.car"),*/
                        
                        switch value {
                        case "walk":
                            iconTravel = "figure.walk"
                            
                        case "bike":
                            iconTravel = "bicycle"
                            
                        case "train":
                            iconTravel = "train.side.front.car"
                            
                        default:
                            print("Have you done something new?")
                        }
                        
                        mapBikeMarkers = vm.mapMarkers//(value)
                        
                    }
                    //Slider(value: $value)
                    //vm.updateStations(selectedTransit.rawValue)
                    
                    
                }
            }.onAppear() {
                vm.getSharedBikes()
                //getBikeStations()
                mapBikeMarkers = vm.mapMarkers
                
            }
        }
    }
}

struct BikeMapView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
        //BikeMapView()//sbViewModel:SharedBikeViewModel())
    }
}
