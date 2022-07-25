//
//  GetAllBikesUseCaseProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

protocol GetAllSharedBikesUseCaseProtocol {
    // func execute() async -> Result<[StationInfo], SharedBikesError>
    func execute() async throws -> [Station]
}

protocol GetAllBartStationsUseCaseProtocol {
    // func execute() async -> Result<[StationInfo], SharedBikesError>
    func execute() async throws -> [BartStation]
}

protocol GetAllWalkingRoutesUseCaseProtocol {
    // func execute() async -> Result<[StationInfo], SharedBikesError>
    func execute() async throws -> [WalkingRoutePts]
}


protocol GetCurrentCalEventUseCaseProtocol {
    func execute() async throws -> CurrentCalEvent
    func execute(myEvent: String, loc :CLLocation) async throws
}
