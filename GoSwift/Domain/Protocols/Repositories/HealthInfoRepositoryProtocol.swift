//
//  SharedBikeRepositoryProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

protocol HealthInfoRepositoryProtocol {
    func getHealthInfo(activity:ActivityType) async throws -> HealthWorkoutInfo
}


//DO NOT DO THIS !!!! func getAllSharedBikes() async ->  Result<[StationInfo], SharedBikesError>
/*protocol SharedBikesRepositoryNotReactiveResultProtocol { // not reactive
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}*/

