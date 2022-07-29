//
//  SharedBikeRepositoryProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import EventKit

protocol CalEventsRepositoryProtocol {
    func getCalEvents() async throws -> [EKEvent]?
}


//DO NOT DO THIS !!!! func getAllSharedBikes() async ->  Result<[StationInfo], SharedBikesError>
/*protocol SharedBikesRepositoryNotReactiveResultProtocol { // not reactive
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}*/

