//
//  SharedBikeRepositoryProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

protocol BartStationsRepositoryProtocol {
    func getAllBartStations() async throws -> [BartStation]
}


//DO NOT DO THIS !!!! func getAllSharedBikes() async ->  Result<[StationInfo], SharedBikesError>
/*protocol SharedBikesRepositoryNotReactiveResultProtocol { // not reactive
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}*/

