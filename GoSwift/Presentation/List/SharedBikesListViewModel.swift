//
//  SharedBikesListViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//
import Foundation
import Combine
import MapKit
import os.log

class SharedBikesListViewModel: ObservableObject{
    
    let logger = Logger(subsystem: "com.ylabz.GoSwift", category: "ListBikes")
    
    private let getAllSharedBikes : GetAllSharedBikesUseCaseProtocol
    init(getAllSharedBikes: GetAllSharedBikesUseCaseProtocol){
        self.getAllSharedBikes = getAllSharedBikes
        // timerGetAllSharedBike()
    }
    
    // From Combine  // Get publisher from UseCases.
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    
    @Published private(set) var  isSearching = false
    @Published private(set) var sharedBikeStations : [Station] = []
    @Published private(set) var mapMarkers :  [MapAnnotationItem] = []
    
    private var bikeSearchTask: Task<Void, Never>? = nil

    
    @MainActor
    func getSharedBikes() { // async - Swift runtime an decide to execute on non-main thread
        bikeSearchTask?.cancel()
        
        // TODO:  bikeSearchTask = Task not working
        Task {
            isSearching = true

            sharedBikeStations =  try! await getAllSharedBikes.execute()//Execute the use case
                
            sharedBikeStations.forEach{ station in
                logger.debug("\(station.name)")
                print("BikeListVM \(station)")
                mapMarkers.append(MapAnnotationItem(station: station, coordinate: CLLocationCoordinate2DMake(station.lat, station.lon)))
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
