//
//  TransStation.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/9/22.
//

import Foundation

protocol TransportationStation : Codable, Identifiable, Hashable {
    var name: String {get}
    var lon: Double {get}
    var lat: Double {get}
}
