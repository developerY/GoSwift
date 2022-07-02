//
//  SharedBikesSourceProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

protocol SharedBikesDataSourceProtocol{
    func getSysInfo() async throws -> SysInfoDataClass
    func getStationInfo() async throws -> [Station]
}

/*
 
 Combine
 protocol SharedBikesDataSourceProtocolPublisher{
     func sysInfo()  -> AnyPublisher<SystemInfo, Error> // because combine will return a published for URL call
     func stationInfo()  -> AnyPublisher<StationInfo, Error> // Result<[SharedBikesResponseModel], SharedBikesError>
 }

 DO NOT DO THIS
 protocol SharedBikesDataSourceProtocolResult{
     func sysInfo() async -> Result<SystemInfo, Error>
     func stationInfo() async -> Result<StationInfo, Error>
 }

 */


