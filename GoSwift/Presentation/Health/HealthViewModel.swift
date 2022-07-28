//
//  HealthModelView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/24/22.
//

import Foundation
import SwiftUI
import HealthKit


class HealthViewModel: ObservableObject{
    
    // TODO: REMOVE THIS!
    @ObservedObject var healthRepo = HealthRepo() // NOTE: HealthViewModel should never talk to the repo (Use Case Protocal)
    @Published private(set) var  steps:[Int] = [0]
    init() {
        Task{
            // NOTE might want to make this throw
            await healthRepo.requestAuthorization()
        }
    }
    
    func getHealthInfo(healthType:String) async {
        await healthRepo.loadNewDataFromHealthKit()
        steps.removeAll()
        let samples = healthRepo.samples
        samples?.forEach { sample in
            steps.append(Int(sample.description.split(by: " ")[1]) ?? 0)
        }
    }
    
    
    // MARK: - Private Methods
    // MARK: - Not Used Experimental Methods
    private func getWorkouts() -> [Int] {
        var workouts: [HKSample]?
        var distance:[Int] = []
        Task {
            do {
                workouts = try await healthRepo.fetchWorkouts() //.readWorkouts()
            } catch {
                print("Unexpected error in getWorkouts: \(error).")
                // throw(error)
            }
            
            workouts?.forEach { workout in
                print("These are the work outs \(workout.description.split(by: " ")[1])")
                distance.append(Int(workout.description.split(by: " ")[1]) ?? 0)
            }
        }
        return distance
    }
    
    
}
