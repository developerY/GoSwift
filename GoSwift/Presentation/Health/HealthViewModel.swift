//
//  HealthModelView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/24/22.
//

import Foundation
import SwiftUI


class HealthViewModel: ObservableObject{
    
    // TODO: REMOVE THIS!
    @ObservedObject var healthRepo = HealthRepo() // NOTE: HealthViewModel should never talk to the repo (Use Case Protocal)
    
    init() {
        Task{
            do {
                try await healthRepo.requestAuth()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func getSteps() {
        healthRepo.getSteps()
    }
    
}
