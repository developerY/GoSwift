//
//  SharedBikesRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine


// Repository calls the DataSource BikeStationsDataSourceProtocol
class WalkingRoutesRepository : WalkingRoutesRepositoryProtocol {
    private let walkingRoutesDataSource: WalkingRoutesDataSourceProtocol

    init(walkingRoutesDataSource: WalkingRoutesDataSourceProtocol){
        self.walkingRoutesDataSource = walkingRoutesDataSource
    }
    
    func getAllWalkingRoutes() async throws -> [WalkingRoutePts] {
        try await walkingRoutesDataSource.getStationInfo()
    }

}


/*func getAllSharedBikes() {//async -> AnyPublisher<StationInfo, any Error>  { // We it to be reactive. Not use Result<[SharedBikesResponseModel], SharedBikesError> {
    // return await sharedBikesDataSource.stationInfo()
}*/
