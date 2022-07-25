//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

class GetAllSharedBikes : GetAllSharedBikesUseCaseProtocol {
    private let sharedBikesRepo: SharedBikesRepositoryProtocol
    init(sharedBikesRepo : SharedBikesRepositoryProtocol) {
        self.sharedBikesRepo = sharedBikesRepo
    }
    
    // MARK: Get all shared bike stations
    func execute() async throws ->  [Station] {
        return try await sharedBikesRepo.getAllSharedBikes()
    }
}
