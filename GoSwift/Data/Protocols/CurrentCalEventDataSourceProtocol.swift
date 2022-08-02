//
//  SharedBikesSourceProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

protocol CurrentCalEventDataSourceProtocol{
    func getCurrentCalEvent() async throws -> CurrentCalEvent
    func setCurrentCalEvent(myEvent: String, eventDate:Date, loc :CLLocation) async throws
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


