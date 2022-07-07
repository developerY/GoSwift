//
//  MapAnnotation.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/6/22.
//

import Foundation
import MapKit
struct MapAnnotationItem : Identifiable {
    var stationName :String
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}


