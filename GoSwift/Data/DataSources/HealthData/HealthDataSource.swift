//
//  HealthRepo.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/23/22.
//

import Foundation
import HealthKit
import os

enum ActivityType {
    case steps ,bike
}

// The HealthKit store.
private let healthStore = HKHealthStore()
private let isAvailable = HKHealthStore.isHealthDataAvailable()

private let sampleTypes: Set<HKSampleType> =
[HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
 HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!]

class HealthInfoDataSource: HealthInfoDataSourceProtocol {
    
    init() {
        Task {
            await requestAuthorization()
        }
    }
    
    func getHealthInfo(activity: ActivityType) async throws -> HealthWorkoutInfo {
        
        guard isAvailable else {
            logger.debug("HealthKit is not available on this device.")
            // return zero data
            return [0]
        } // Happy Path
        
        let nums = try await loadNewDataFromHealthKit(activity: activity)
        return nums
    }
    
    let logger = Logger(subsystem: "com.ylabz.goswift.HealthRepo", category: "HealthKit")
    
    // MARK: - Properties
    // Indicates whether the user has authroized access to their health data
    private lazy var isAuthorized = false
    
    
    // MARK: - Public Methods
    
    
    /*func requestAuth() async throws {
     try await healthStore?.requestAuthorization(toShare: [], read: stepType)
     }*/
    
    // Reads data from the HealthKit store.
    // MARK: - Private Methods
    private func requestAuthorization() async -> Bool {
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
    
    
    @discardableResult
    private func loadNewDataFromHealthKit(activity: ActivityType) async throws -> [Int] {
        logger.debug("Loading data from HealthKit")
        var loadActivityData = HealthWorkoutInfo([0])
        
        do {
            let samples = try await queryHealthKit(activityType: activity)
            
            samples?.forEach { sample in
                loadActivityData.append(Int(sample.description.split(by: " ")[1]) ?? 0)
            }
        }
        
        return loadActivityData
    }
    
    private func queryHealthKit(activityType: ActivityType) async throws -> ([HKSample]?) {
        return try await withCheckedThrowingContinuation { continuation in
            // Create a predicate that only returns samples created within the last 24 hours.
            let endDate = Date()
            let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
            //let startDate = endDate.addingTimeInterval(-24.0 * 60.0 * 60.0)
            let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate, .strictEndDate])
            
            //Cannot use activityTypes because convert value of type 'Set<HKSampleType>' to expected argument type 'HKSampleType'
            
            // Set step type
            let activitySample: HKSampleType
            switch activityType {
            case .steps:
                activitySample = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
            case .bike:
                activitySample = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!
            }
                
                
                // Create the query.
                let query = HKSampleQuery( //HKAnchoredObjectQuery(
                    sampleType: activitySample,
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
    }

