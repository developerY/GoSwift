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
    let myEventLoc :CLLocation = CLLocation.init(latitude: 37.773972, longitude: -122.431297)
    var currEvnt : CurrentCalEvent
    init() {
        currEvnt  = CurrentCalEvent(eventName: "NO EVENT SET", eventDate: Date(),location:myEventLoc)
    }

    func getCurrentCalEvent() async throws -> CurrentCalEvent {
        return currEvnt
    }
    
    func setCurrentCalEvent(myEvent: String, eventDate:Date, loc :CLLocation) {
        currEvnt = CurrentCalEvent(eventName: myEvent, eventDate: eventDate,location:loc)
    }
}
