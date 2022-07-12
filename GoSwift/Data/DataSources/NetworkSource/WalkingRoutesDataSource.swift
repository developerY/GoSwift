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
        let  center : WalkingRoutePts  = WalkingRoutePts(name: "Center", lat: 37.7749, lon: -122.4194)
        walkPts.append(center)
        let  walkPt : WalkingRoutePts  = WalkingRoutePts(name: "first", lat: 37.803664, lon: -122.271604)
        walkPts.append(walkPt)

        return walkPts
    }
    
    
}
