//
//  CurrentCalEvent.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/15/22.
//

import Foundation
import CoreLocation

struct CurrentCalEvent : Identifiable{
    let id = UUID()
    var eventName:String
    var location:CLLocation
}
