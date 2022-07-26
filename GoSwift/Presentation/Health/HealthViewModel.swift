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
    
    init() {
        Task{
            do {
                try await healthRepo.requestAuth()
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    func getWorkouts() -> [Int] {
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
