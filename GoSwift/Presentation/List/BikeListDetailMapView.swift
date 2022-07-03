//
//  BikeListDetailView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//

import SwiftUI
import MapKit

struct MyAnnotationItem : Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct BikeListDetailMapView: View {
    var station:Station
    @State var lat:Double
    @State var lon:Double
    var annotationItems: [MyAnnotationItem]
    

    
    
    /*@State private var region = MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: station.lat, longitude: station.lon),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )*/
    
    init(station:Station) {
        self.station = station
        _lat = State(initialValue: station.lat)
        _lon = State(initialValue: station.lon)
        
        // place pin on station
        annotationItems = [
            MyAnnotationItem(coordinate : CLLocationCoordinate2D(latitude: station.lat, longitude: station.lon))
        ]
    }
    
    
    var body: some View {
        VStack {
            MapView(lat: $lat, lon: $lon, annotationItems: annotationItems).ignoresSafeArea(edges: .top).frame(height:300)
            //CircleImage()
            VStack(alignment: .leading) {
                
                
                
                
                
                Text("Station")
                    .font(.title)
            }
        }
    }
}

struct MapView: View {
    @Binding private var lat:Double
    @Binding private var lon:Double
    
    var annotationItems: [MyAnnotationItem]
    
    private let initLatMeters:Double = 250
    private let initLonMeters: Double = 250
    
    @State private var span: MKCoordinateSpan?
    
    
    
    init(lat:Binding<Double>, lon:Binding<Double>,
         annotationItems: [MyAnnotationItem]) {
        _lat = lat
        _lon = lon
        self.annotationItems = annotationItems
    }
    
    private var region: Binding<MKCoordinateRegion> {
        Binding {
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            if let span = span {
                return MKCoordinateRegion(center: center, span: span)
            }  else {
                return MKCoordinateRegion(center: center, latitudinalMeters: initLonMeters, longitudinalMeters: initLonMeters)
            }
            
        }set: { region in
            lat = region.center.latitude
            lon = region.center.longitude
            span = region.span
        }
    }
    
    var body: some View {
        Map (coordinateRegion: region, annotationItems: annotationItems) { item in
            MapMarker(coordinate: item.coordinate)
        }
    }
    
    
}

struct BikeListDetailView_Previews: PreviewProvider {
    
    let station : Station? = nil

    static var previews: some View {
        //BikeListDetailMapView(station: station!)
        Text("missing")
    }
}
