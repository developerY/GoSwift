//
//  SharedBikesRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine


// Repository calls the DataSource BikeStationsDataSourceProtocol
class BartStationsRepository : BartStationsRepositoryProtocol {
    private let bartStationsDataSource: BartStationsDataSourceProtocol

    init(bartStationsDataSource: BartStationsDataSourceProtocol){
        self.bartStationsDataSource = bartStationsDataSource
    }
    
    func getAllBartStations() async throws -> [BartStation] {
        try await bartStationsDataSource.getStationInfo()
    }

}


/*func getAllSharedBikes() {//async -> AnyPublisher<StationInfo, any Error>  { // We it to be reactive. Not use Result<[SharedBikesResponseModel], SharedBikesError> {
    // return await sharedBikesDataSource.stationInfo()
}*/
