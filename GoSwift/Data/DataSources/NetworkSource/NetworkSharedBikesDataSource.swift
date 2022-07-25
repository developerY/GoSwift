//
//  NetworkSharedBikesDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//

import Foundation

enum BikeNetworkAPIError: Error {
    case netNotWork
    case badData
}

// Concrete class that make async network call
class NetworkSharedBikesDataSource : SharedBikesDataSourceProtocol, ObservableObject, Identifiable {
    
    
    func  getSysInfo() async throws -> SysInfoDataClass {
        let url = stationURLComponents().url!
        let (data, _) = try await URLSession.shared.data(from: url) //  Swift Structured Concurrency. Nonblocking
        let bikeStations = try JSONDecoder().decode(SystemInfo.self,from:data)
        return bikeStations.data
    }
    
    func getStationInfo() async throws -> [Station]{
        let url = stationURLComponents().url!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw BikeNetworkAPIError.netNotWork
        }
        
        guard let bikeStations = try? JSONDecoder().decode(StationInfo.self,from:data) else {
            throw BikeNetworkAPIError.badData
        }
        
        return bikeStations.data.stations
    }
    
    func getStationInfoNotSafe() async throws -> [Station]{
        let url = stationURLComponents().url!
        let (data, _) = try await URLSession.shared.data(from: url)
        let bikeStations = try JSONDecoder().decode(StationInfo.self,from:data)
        return bikeStations.data.stations
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
