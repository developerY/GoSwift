//
//  BikeMapView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//

import SwiftUI
import MapKit

struct BikeMapView: View {
    //@ObservedObject var sbViewModel:SharedBikeViewModel
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
        
        var body: some View {
            Map(coordinateRegion: $region)
        }
}

struct BikeMapView_Previews: PreviewProvider {
    static var previews: some View {
        BikeMapView()//sbViewModel:SharedBikeViewModel())
    }
}
