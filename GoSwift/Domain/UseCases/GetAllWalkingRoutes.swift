//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

class GetAllWalkingRoutes : GetAllWalkingRoutesUseCaseProtocol {
    private let walkingRoutesRepo: WalkingRoutesRepositoryProtocol
    init(walkingRoutesRepo : WalkingRoutesRepositoryProtocol) {
        self.walkingRoutesRepo = walkingRoutesRepo
    }
    
    // MARK: Get all shared bike stations
    func execute() async throws ->  [WalkingRoutePts] {
        return try await walkingRoutesRepo.getAllWalkingRoutes()
    }
}
