//
//  BartStations.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/9/22.
//

import Foundation
struct BartStation : TransportationStation, Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double

    
    
    static func == (lhs: BartStation, rhs: BartStation) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, name
    }
    
    
    
}
