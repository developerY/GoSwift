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
    
    
    func getStationInfo() async throws -> [Station]{
        let  station : Station  = Station(regionID: nil, eightdHasKeyDispenser: false, stationType: GoSwift.StationType.classic, lon: -122.44419392209238, name: "Hearst Ave at Detroit St", hasKiosk: true, electricBikeSurchargeWaiver: false, rentalUris: GoSwift.RentalUris(android: "https://sfo.lft.to/lastmile_qr_scan", ios: "https://sfo.lft.to/lastmile_qr_scan"), capacity: 19, shortName: "SF-X16", rentalMethods: [GoSwift.RentalMethod.creditcard, GoSwift.RentalMethod.key], lat: 37.73075943972763, stationID: "578", eightdStationServices: [], externalID: "41b2200f-7915-410b-95c6-084bc4d3dee8", legacyID: "578")
        return [station]
    }

}

// MARK: URL
private extension NetworkSharedBikesDataSource {
    struct GobalBikeAPI {
        static let scheme = "https"
        static let host = "gbfs.baywheels.com"
        static let path = "/gbfs/en"
        //static let key = "<your key>"
    }
    
    func stationURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = GobalBikeAPI.scheme
        components.host = GobalBikeAPI.host
        components.path = GobalBikeAPI.path + "/station_information.json"
        
        components.queryItems = [
            //URLQueryItem(name: "name", value: value)
        ]
        return components
    }
    
    func systemURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = GobalBikeAPI.scheme
        components.host = GobalBikeAPI.host
        components.path = GobalBikeAPI.path + "/system_information.json"
        
        components.queryItems = [
            //URLQueryItem(name: "name", value: value)
        ]
        return components
    }
}
