//
//  SharedBikeRepositoryProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

protocol CurrentCalEventRepositoryProtocol {
    func getCurrentCalEvent() async throws -> CurrentCalEvent
    func setCurrentCalEvent(myEvent: String, loc :CLLocation) async throws
}


//DO NOT DO THIS !!!! func getAllSharedBikes() async ->  Result<[StationInfo], SharedBikesError>
/*protocol SharedBikesRepositoryNotReactiveResultProtocol { // not reactive
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}*/

