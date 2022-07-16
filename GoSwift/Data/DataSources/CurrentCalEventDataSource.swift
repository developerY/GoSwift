//
//  CurrentCalEventDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/15/22.
//

import Foundation
import CoreLocation



// Concrete class that make async network call
class CurrentCalEventDataSource : CurrentCalEventDataSourceProtocol, ObservableObject, Identifiable {
    let myEventLoc :CLLocation = CLLocation.init(latitude: 37.22, longitude: -122.22)
    var currEvnt : CurrentCalEvent
    init() {
        currEvnt  = CurrentCalEvent(eventName: "SF Downtown",location:myEventLoc)
    }

    func getCurrentCalEvent() async throws -> CurrentCalEvent {
        return currEvnt
    }
    
    func setCurrentCalEvent(myEvent: String, loc :CLLocation) {
        currEvnt = CurrentCalEvent(eventName: myEvent,location:loc)
    }
}
