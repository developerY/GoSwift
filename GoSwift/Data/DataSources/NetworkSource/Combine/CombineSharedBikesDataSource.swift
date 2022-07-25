//
//  NetworkSharedBikesDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine

// Concrete class that make network call
class CombineSharedBikesDataSource: ObservableObject,Identifiable {
   
    func getSysInfo()  -> SysInfoDataClass? {
        return sysInfo
    }
    
    func getStationInfo() -> [Station] {
        return stations
    }
    
        
    @Published var stations: [Station] = []
    @Published var sysInfo: SysInfoDataClass? = nil
    private var disposables = Set<AnyCancellable>()
    private let bikeInfoService = BikeInfoAPI()
    
    init() {
        sysStationCall()
        sysInfoCall()
    }
    
    func sysStationCall() {
        bikeInfoService.stationInfo() // Publisher <StationInfo, Never Error>
            //.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {print ("Received completion: \($0).")},
                  receiveValue: {data in
                  print ("Received Station Data: \(data.data.stations[0]).")
                self.stations = data.data.stations
            })
            .store(in: &disposables)  // commet out in demo
    }
    
    func sysInfoCall() {
        bikeInfoService.sysInfo() // Publisher <StationInfo, Never Error>
            //.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {print ("Received completion: \($0).")},
                  receiveValue: {data in
                self.sysInfo = data.data
            })
            .store(in: &disposables)  // commet out in demo
    }

}
