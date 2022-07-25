//
//  HealthRepo.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/23/22.
//

import Foundation
import HealthKit
extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

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
    
    func getSteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            let endDate = Date()
            
            statisticsCollection?.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                
                let count = statistics.sumQuantity()?.doubleValue(for: .count())
                
                print("Steps count \(String(describing: count))")
            }
        }
        
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
}
