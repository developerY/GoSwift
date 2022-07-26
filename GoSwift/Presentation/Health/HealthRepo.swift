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
    
    let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    
    let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
    
    let anchorDate = Date.mondayAt12AM()
    
    let daily = DateComponents(day: 1)
    
    let predicate : NSPredicate
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore =  HKHealthStore()
        }
        predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
    }
    
    func requestAuth() async throws {
        let stepType : Set = [
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!,
            HKSeriesType.activitySummaryType(),
            HKSeriesType.workoutRoute(),
            HKSeriesType.workoutType()
        ]
        try await healthStore?.requestAuthorization(toShare: [], read: stepType)
    }
    
    
    
    func readWorkouts() async throws -> [HKSample]? {
        //let cycling = HKQuery.predicateForWorkouts(with: .)
        let samples: [HKSample]?
        
        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!
        
        do {
            samples = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
                
                healthStore?.execute(
                    HKSampleQuery(sampleType: sampleType,
                                  predicate: nil, //cycling,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil,//[.init(keyPath: \HKSample.startDate, ascending: false)],
                                  resultsHandler: { query, samples, error in
                                      // throw the error
                                      if let hasError = error {
                                          //throw(hasError)
                                          continuation.resume(throwing: hasError)
                                          return
                                      }
                                      
                                      guard let samples = samples else {
                                          fatalError("*** Invalid State: This can only fail if there was an error. ***")
                                      }
                                      // Happy path
                                      continuation.resume(returning: samples)
                                  }))
            }
        }
    
        /*guard let workouts = samples as? [HKWorkout] else {
            return nil
        }*/
        
        //print("This is the workout \(workouts)")
        return samples
    }
    
    /*func getSteps() async ->  {
     
     let steps : [Double]
     query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
     
     query!.initialResultsHandler = { query, statisticsCollection, error in
     let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
     let endDate = Date()
     
     statisticsCollection?.enumerateStatistics(from: startDate, to: endDate) { steps in
     steps = steps
     }
     }
     
     if let healthStore = healthStore, let query = self.query {
     healthStore.execute(query)
     }
     
     return count
     
     }*/
    
}
