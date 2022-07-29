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
    
    init(getAllHealtInfo: GetHealthInfoUseCaseProtocol){
        self.getAllHealthInfo = getAllHealtInfo
    }
    
    @MainActor
    func getTotalSteps() -> Int {
        var steps:[Int]?
        Task {
            steps = try await getAllHealthInfo.execute(activity: "steps")
        }
        steps?.forEach { step in
            totalHealthSteps += step
        }
        return totalHealthSteps
    }
    
}
