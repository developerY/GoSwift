//
//  NetworkSharedBikesDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//

import Foundation
import Combine

// Concrete class that make async network call
class BartStationsDataSource : BartStationsDataSourceProtocol, ObservableObject, Identifiable {
    
    
    func getStationInfo() async throws -> [BartStation]{
        var bartStations : [BartStation] = []
        
        let  station1 : BartStation  = BartStation(name: "Embarcadero", lat: 37.792683, lon: -122.397198)
        bartStations.append(station1)
        
        let  station2 : BartStation  = BartStation(name: "Montgomery St", lat: 37.78139, lon: -122.401511)
        bartStations.append(station2)
        
        let  station3 : BartStation  = BartStation(name: "Powel Street", lat: 37.78203, lon: -122.408075)
        bartStations.append(station3)
        
        
        let  station4 : BartStation  = BartStation(name: "Civic Center", lat: 37.779421, lon: -122.413634)
        bartStations.append(station4)
        
        
        return bartStations
    }

}
