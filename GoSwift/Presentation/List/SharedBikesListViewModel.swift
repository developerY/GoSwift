//
//  SharedBikesListViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//
import Foundation
import Combine

class SharedBikesListViewModel: ObservableObject{
    private let getAllSharedBikes : GetAllSharedBikesUseCaseProtocol
    init(getAllSharedBikes: GetAllSharedBikesUseCaseProtocol){
        self.getAllSharedBikes = getAllSharedBikes
        // timerGetAllSharedBike()
    }
    
    // From Combine  // Get publisher from UseCases.
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    
    @Published private(set) var  isSearching = false
    @Published private(set) var sharedBikes : [Station] = []
    
    private var bikeSearchTask: Task<Void, Never>? = nil

    
    @MainActor
    func getSharedBikes() { // async - Swift runtime an decide to execute on non-main thread
        bikeSearchTask?.cancel()
        
        // TODO:  bikeSearchTask = Task not working
        Task {
            isSearching = true
            sharedBikes =  try await getAllSharedBikes.execute()//Execute the use case
            
            sharedBikes.forEach{ station in
                print(station.name)
            }
            if !Task.isCancelled {
                isSearching = false
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
