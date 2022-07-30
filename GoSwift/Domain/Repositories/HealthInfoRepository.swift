//
//  HealthInfoRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/28/22.
//

import Foundation

class HealthInfoRepository : HealthInfoRepositoryProtocol {
    private let healthInfoDataSource: HealthInfoDataSourceProtocol

    init(healthInfoDataSource: HealthInfoDataSourceProtocol){
        self.healthInfoDataSource = healthInfoDataSource
    }
    
    func getHealthInfo(activity:ActivityType) async throws -> HealthWorkoutInfo {
        try await healthInfoDataSource.getHealthInfo(activity: activity)
    }

}
