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
    
    
    private let getAllHealthInfo : GetHealthInfoUseCaseProtocol
    @Published private(set) var totalHealthSteps = 0 // add up all health step to get total
    @Published private(set) var totalHealthBikeMiles = 0
    
    init(getAllHealtInfo: GetHealthInfoUseCaseProtocol){
        self.getAllHealthInfo = getAllHealtInfo
    }
    
    @MainActor
    func getTotalStepsAndBike() {
        Task {
            let steps = try await getAllHealthInfo.execute(activity: ActivityType.steps)
            steps.forEach { step in
                totalHealthSteps += step
            }
            
            let bikeMiles = try await getAllHealthInfo.execute(activity: ActivityType.bike)
            bikeMiles.forEach { bkMile in
                totalHealthBikeMiles += bkMile
            }
        }
    }
}
