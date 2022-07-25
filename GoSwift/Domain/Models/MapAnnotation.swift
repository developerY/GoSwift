//
//  MapAnnotation.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/6/22.
//

import Foundation
import MapKit
struct MapAnnotationItem : Identifiable {
    var station : any TransportationStation // new in Swift 5.7
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}


