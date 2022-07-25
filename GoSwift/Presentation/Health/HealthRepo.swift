//
//  HealthRepo.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/23/22.
//

import Foundation
import HealthKit


class HealthRepo: ObservableObject {
    
    var healthStore : HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore =  HKHealthStore()
        }
    }
    
    func requestAuth() async throws {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        try await healthStore?.requestAuthorization(toShare: [], read: [stepType])
    }
    
}
