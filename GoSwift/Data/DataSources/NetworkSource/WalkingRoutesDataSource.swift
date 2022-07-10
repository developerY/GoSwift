//
//  NetworkSharedBikesDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//

import Foundation
import Combine

// Concrete class that make async network call
class WalkingRoutesDataSource : WalkingRoutesDataSourceProtocol, ObservableObject, Identifiable {
    
    func getStationInfo() async throws -> [WalkingRoutePts]{
        var walkPts : [WalkingRoutePts] = []
        let  walkPt : WalkingRoutePts  = WalkingRoutePts(name: "first", lat: 37.803664, lon: -122.271604)
        walkPts.append(walkPt)
        return walkPts
    }
    
    
}
