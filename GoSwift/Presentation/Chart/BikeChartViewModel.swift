//
//  SharedBikesListViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//
import Foundation
import Combine

class BikeChartViewModel: ObservableObject{
    @Published private(set) var  motion = 20.0
    private var bikeSearchTask: Task<Void, Never>? = nil
        
    // var genRandomListOverTime : () -> Int  = genNums() { Task { return Int }}
        
    @MainActor
    func runRandom() { // async - Swift runtime an decide to execute on non-main thread
        Task {
            for _ in 1...100 {
                self.motion = Double.random(in: 1...100)
                print("num \(motion)")
                try await Task.sleep(nanoseconds: 2_000_000_000)
            }
        }
        }

    }

/*
 Given to the view
 @ObservedObject var viewModel = SharedBikeViewModel()
 let stations = viewModel.stations -> @Published var stations: [Station] = [] -> 
 Used in LazyVGrid
 ForEach(stations) { item in
 */
