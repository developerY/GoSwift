//
//  GetAllBikesUseCaseProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation
import EventKit

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


typealias HealthWorkoutInfo = [Date: Int]
protocol GetHealthInfoUseCaseProtocol {
    func execute(activity:ActivityType) async throws -> HealthWorkoutInfo
}

protocol CalEventsUseCaseProtocol {
    func execute() async throws -> [EKEvent]?
}

