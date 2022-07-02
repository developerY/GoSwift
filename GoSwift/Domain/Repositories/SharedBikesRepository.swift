//
//  SharedBikesRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine


// Repository calls the DataSource
class SharedBikesRepository : SharedBikesRepositoryProtocol {
    private let sharedBikesDataSource: SharedBikesDataSourceProtocol

    init(sharedBikesDataSource: SharedBikesDataSourceProtocol){
        self.sharedBikesDataSource = sharedBikesDataSource
    }
    
    func getAllSharedBikes() async throws -> [Station] {
        try await sharedBikesDataSource.getStationInfo()
    }

}


/*func getAllSharedBikes() {//async -> AnyPublisher<StationInfo, any Error>  { // We it to be reactive. Not use Result<[SharedBikesResponseModel], SharedBikesError> {
    // return await sharedBikesDataSource.stationInfo()
}*/
