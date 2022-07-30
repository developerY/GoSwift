//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

class GetHealthInfo : GetHealthInfoUseCaseProtocol {

    private let healthInfoRepo: HealthInfoRepositoryProtocol
    init(healthInfoRepo : HealthInfoRepositoryProtocol) {
        self.healthInfoRepo = healthInfoRepo
    }
    
    // MARK: Get/Set current event
    func execute(activity: ActivityType) async throws -> HealthWorkoutInfo {
        return try await healthInfoRepo.getHealthInfo(activity: activity)
    }
}
