//
//  SharedBikesRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation


// Repository calls the DataSource BikeStationsDataSourceProtocol
class CurrentCalEventRepository : CurrentCalEventRepositoryProtocol {
    private let currentCalEventDataSource: CurrentCalEventDataSourceProtocol

    init(currentCalEventDataSource: CurrentCalEventDataSourceProtocol){
        self.currentCalEventDataSource = currentCalEventDataSource
    }
    
    func getCurrentCalEvent() async throws -> CurrentCalEvent {
        try await currentCalEventDataSource.getCurrentCalEvent()
    }
    
    func setCurrentCalEvent(myEvent: String, loc: CLLocation) async throws {
        try await currentCalEventDataSource.setCurrentCalEvent(myEvent: myEvent, loc: loc)
    }

}


/*func getAllSharedBikes() {//async -> AnyPublisher<StationInfo, any Error>  { // We it to be reactive. Not use Result<[SharedBikesResponseModel], SharedBikesError> {
    // return await sharedBikesDataSource.stationInfo()
}*/
