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

    // TODO: REMOVE THIS!
    @ObservedObject var calRepo = CalendarRepo() // NOTE: calendar should never talk to the repo
    var events: [EKEvent]?
    
    @Published private(set) var currentCalEvent : CurrentCalEvent = CurrentCalEvent(eventName: "NOT SET!", location: CLLocation.init(latitude: 37.0, longitude: -122.0))
    
    init(getCurrentCalEvent: GetCurrentCalEventUseCaseProtocol) {
        self.getCurrentCalEvent = getCurrentCalEvent
        events = calRepo.loadEvents() ?? [EKEvent()]
    }
    
    @MainActor
    func getCurrentEvent() {
        Task {
            try await currentCalEvent = getCurrentCalEvent.execute()
        }
    }
    
    @MainActor
    func setCurrentEvent(myEvent: String, eventLoc: CLLocation) {
        Task {
            try await getCurrentCalEvent.execute(myEvent:myEvent, loc:eventLoc)
        }
    }
}
