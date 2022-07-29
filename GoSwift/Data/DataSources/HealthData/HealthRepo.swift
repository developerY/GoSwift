//
//  HealthRepo.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/23/22.
//

import Foundation
import HealthKit
import os


private let sampleTypes: Set<HKSampleType> =
[HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
 HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!]
// for workouts HKSeriesType.activitySummaryType(), HKSeriesType.workoutRoute(), HKSeriesType.workoutType()

// The HealthKit store.
private let healthStore = HKHealthStore()
private let isAvailable = HKHealthStore.isHealthDataAvailable()

// NOT NEEDED
var query: HKStatisticsCollectionQuery?
let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
let anchorDate = Date.mondayAt12AM()
let daily = DateComponents(day: 1)
// let predicate : NSPredicate

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

// might be actor?
class HealthInfoDataSource: HealthInfoDataSourceProtocol {

    init() {
        Task {
            await load()
            await loadNewDataFromHealthKit()
        }
    }
    
    func getHealthInfo(activity: String) async throws -> HealthWorkoutInfo {
        return HealthWorkoutInfo([10])
    }
    
    // read health data
    func load() async {
        guard await requestAuthorization() else {
            logger.debug("unable to authorize HealthKit.")
            return
        }
    }
    
    let logger = Logger(subsystem: "com.ylabz.goswift.HealthRepo", category: "HealthKit")
    
    // MARK: - Properties
    // Indicates whether the user has authroized access to their health data
    private lazy var isAuthorized = false
    @Published var samples: [HKSample]?

    
    // MARK: - Public Methods
    func requestAuthorization() async -> Bool {
        guard isAvailable else { return false }
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: sampleTypes)
            self.isAuthorized = true
            return true
        } catch let error {
            self.logger.error("An error occurred while requesting HealthKit Authorization: \(error.localizedDescription)")
            return false
        }
    }
    
    /*func requestAuth() async throws {
     try await healthStore?.requestAuthorization(toShare: [], read: stepType)
     }*/
    
    // Reads data from the HealthKit store.
    @discardableResult
    public func loadNewDataFromHealthKit() async -> Bool {
        
        guard isAvailable else {
            logger.debug("HealthKit is not available on this device.")
            return false
        }
        
        logger.debug("Loading data from HealthKit")
        
        do {
            samples = try await queryHealthKit()
            return true
        } catch {
            self.logger.error("An error occurred while querying for samples: \(error.localizedDescription)")
            return false
        }
    }
    
    
    
    // MARK: - Private Methods
    func queryHealthKit() async throws -> ([HKSample]?) {
        return try await withCheckedThrowingContinuation { continuation in
            // Create a predicate that only returns samples created within the last 24 hours.
            let endDate = Date()
            let startDate = endDate.addingTimeInterval(-24.0 * 60.0 * 60.0)
            let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate, .strictEndDate])
            
            // Create the query.
            let query = HKSampleQuery( //HKAnchoredObjectQuery(
                sampleType: stepType,
                predicate: nil, // datePredicate,
                //anchor: anchor,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil)
            { (query, samples,error) in
                
                // When the query ends, check for errors.
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: samples)
                }
                
            }
            healthStore.execute(query)
        }
    }
    
    // MARK: - Not Used Experimental Methods
    private func readSamles() async throws -> [HKSample]? {
        //let cycling = HKQuery.predicateForWorkouts(with: .)
        let samples: [HKSample]?
        
        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!
        
        do {
            samples = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
                
                healthStore.execute(
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
                                          // Throw Error
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
    
    
    // NOT USED
    func fetchWorkouts() async throws -> [HKWorkout]? {
        
        let walkingPredicate = HKQuery.predicateForWorkouts(with: .walking)
        let cyclePredicate = HKQuery.predicateForWorkouts(with: .cycling)
        
        
        // 1. Get all workouts with the configured activity type.
        //let walkingPredictate = HKQuery.predicateForWorkouts(with: activityType)
        
        // 2. Get all workouts that only came from this app.
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        
        // 3. Combine the predicates into a single predicate.
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:[cyclePredicate, sourcePredicate])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        typealias WorkoutsContinuation = CheckedContinuation<[HKWorkout], Error>
        
        return try await withCheckedThrowingContinuation { (continuation: WorkoutsContinuation) in
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: compound,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
            ) { query, samples, error in
                guard let samples = samples as? [HKWorkout], error == nil else {
                    if let error = error {
                        print("This is the error\(error)")
                        continuation.resume(throwing: error)
                    }
                    return
                }
                continuation.resume(returning: samples)
            }
            healthStore.execute(query)
        }
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
