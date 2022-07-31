//
//  GeoEventMap.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/30/22.
//

import Foundation
import SwiftUI
import EventKit
import MapKit


private func getCoorRegion(event:EKEvent) async throws -> MKCoordinateRegion? {
    let geoCoder = CLGeocoder()
    
    /*var eventAddress = MKCoordinateRegion(
     center: CLLocationCoordinate2D(latitude: 0.0,
     longitude: 0.0),
     latitudinalMeters: 750,
     longitudinalMeters: 750)*/
    
    
    guard let eventLoc = event.location else {
        return nil
    }
    
    let placemarkes = try await geoCoder.geocodeAddressString(eventLoc)
    if let locPlace = placemarkes[0].location {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: locPlace.coordinate.latitude, longitude: locPlace.coordinate.longitude ),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    }
    return nil
}


struct GeoEventMapView: View {
    let event:EKEvent
    @State var local = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0 ),
               latitudinalMeters: 750,
               longitudinalMeters: 750)
    
    let geoCoder = CLGeocoder()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $local)
        }.onAppear {
            Task {
                if let locString = event.location {
                    let placemarkes = try await geoCoder.geocodeAddressString(locString)
                    if let locPlace = placemarkes[0].location {
                        local = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: locPlace.coordinate.latitude, longitude: locPlace.coordinate.longitude ),
                            latitudinalMeters: 750,
                            longitudinalMeters: 750
                        )
                    }
                }
            }
        }
    }
}

