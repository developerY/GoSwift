//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

class GetAllBartStations : GetAllBartStationsUseCaseProtocol {
    private let bartStationRepo: BartStationsRepositoryProtocol
    init(bartStationRepo : BartStationsRepositoryProtocol) {
        self.bartStationRepo = bartStationRepo
    }
    
    // MARK: Get all shared bike stations
    func execute() async throws ->  [BartStation] {
        return try await bartStationRepo.getAllBartStations()
    }
}
