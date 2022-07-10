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

enum TransitType : String, Equatable, CaseIterable {
    case walk = "figure.walk"
    case bike = "bicycle"
    case train = "train.side.front.car"
}

class BikeMapViewModel: ObservableObject{

    
    let logger = Logger(subsystem: "com.ylabz.GoSwift", category: "ListBikes")
    
    private let getAllSharedBikes : GetAllSharedBikesUseCaseProtocol
    private let getAllBartStations : GetAllBartStationsUseCaseProtocol
    private let getAllWalkingRoutes : GetAllWalkingRoutesUseCaseProtocol
    
    
    init(getAllSharedBikes: GetAllSharedBikesUseCaseProtocol,
         getAllBartStations: GetAllBartStationsUseCaseProtocol,
         getAllWalkingRoutes: GetAllWalkingRoutesUseCaseProtocol){
        self.getAllSharedBikes = getAllSharedBikes
        self.getAllBartStations = getAllBartStations
        self.getAllWalkingRoutes = getAllWalkingRoutes
        // timerGetAllSharedBike()
    }
    
    
    // From Combine  // Get publisher from UseCases.
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    //@Published var sharedBikes : AnyPublisher<StationInfo, any Error>
    
    @Published private(set) var transStations : [any TransportationStation] = []
    @Published private(set) var mapMarkers :  [MapAnnotationItem] = []
    
    private var bikeSearchTask: Task<Void, Never>? = nil


    //["figure.walk","bicycle","train.side.front.car"]
    @MainActor
    func getTransStations(transType: TransitType) { // async - Swift runtime an decide to execute on non-main thread
        //bikeSearchTask?.cancel()
        
        // TODO:  bikeSearchTask = Task not working
        Task {
            switch transType {
            case .walk:
                transStations =  try! await getAllWalkingRoutes.execute()//Execute the use case
            case .bike:
                transStations =  try! await getAllSharedBikes.execute()//Execute the use case
            case .train:
                transStations =  try! await getAllBartStations.execute()//Execute the use case
            }
            
            
            
            
            
            mapMarkers.removeAll()
            transStations.forEach{ station in
                logger.debug("\(station.name)")
                let _ = print("BikeMapVM \(station)")
                mapMarkers.append(MapAnnotationItem(stationName: station.name, coordinate: CLLocationCoordinate2DMake(station.lat, station.lon)))
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
