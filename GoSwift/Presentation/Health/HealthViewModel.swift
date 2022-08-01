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
    
    struct stepData: Identifiable {
       let id = UUID()
       let date: Date
       let stepCount: Int
    }
    
    struct bikeData: Identifiable {
       let id = UUID()
       let date: Date
       let bikeMiles: Int
    }
    
    private let getAllHealthInfo : GetHealthInfoUseCaseProtocol
    @Published private(set) var healthSteps : [stepData] = []
    @Published private(set) var healthBikeMiles : [bikeData] = []
    @Published private(set) var healthStepsDic : HealthWorkoutInfo = [:] // add up all health step to get total
    @Published private(set) var healthBikeMilesDic: HealthWorkoutInfo = [:]
    
    init(getAllHealtInfo: GetHealthInfoUseCaseProtocol){
        self.getAllHealthInfo = getAllHealtInfo
    }
    
    @MainActor
    func getTotalStepsAndBike() {
        Task {
            healthStepsDic = try await getAllHealthInfo.execute(activity: ActivityType.steps)
            healthStepsDic.forEach { step in
                healthSteps.append(stepData(date: step.key, stepCount: step.value))
            }
            healthBikeMilesDic = try await getAllHealthInfo.execute(activity: ActivityType.bike)
            healthBikeMilesDic.forEach { bike in
                healthBikeMiles.append(bikeData(date: bike.key, bikeMiles: bike.value))
            }
        }
    }
}
