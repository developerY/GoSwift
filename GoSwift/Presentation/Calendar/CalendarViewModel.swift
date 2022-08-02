//
//  CalendarViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/12/22.
//

import Foundation
import EventKit
import SwiftUI


class CalendarViewModel: ObservableObject{
    private let getCurrentCalEvent : GetCurrentCalEventUseCaseProtocol
    private let getCalEvents : CalEventsUseCaseProtocol

    // TODO: REMOVE THIS!
    // @ObservedObject var calRepo = CalendarRepo() // NOTE: calendar should never talk to the repo (Use Case Protocal)
    @Published private(set) var events: [EKEvent]?
    
    @Published private(set) var currentCalEvent : CurrentCalEvent = CurrentCalEvent(eventName: "NOT SET!", eventDate: Date(), location: CLLocation.init(latitude: 37.0, longitude: -122.0))
    
    init(getCurrentCalEvent: GetCurrentCalEventUseCaseProtocol,
         getCalEvents : CalEventsUseCaseProtocol) {
        self.getCurrentCalEvent = getCurrentCalEvent
        self.getCalEvents = getCalEvents
    }
    
    
    @MainActor
    func getCalEvents() async {
        Task {
            try await events = getCalEvents.execute()
        }
    }
        
    @MainActor
    func getCurrentEvent() {
        Task {
            try await currentCalEvent = getCurrentCalEvent.execute()
        }
    }
    
    @MainActor
    func setCurrentEvent(myEvent: String, eventDate: Date, eventLoc: CLLocation) {
        Task {
            try await getCurrentCalEvent.execute(myEvent:myEvent,eventDate:eventDate, loc:eventLoc)
        }
    }
}
