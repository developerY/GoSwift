//
//  CalendarRepo.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/13/22.
//
// Made with help from Apple documentation.

import Foundation
import EventKit
import EventKitUI
import SwiftUI

class CalendarRepo: ObservableObject {
    
    var eventStore = EKEventStore()
    var calendar = Calendar.current
    
    @Published var events: [EKEvent]?
    
    func getPermission(){
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                print("CAL ACCESS granted \(granted)")
            }
            else{
                print("CAL ACCESS failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
    
    func loadEvents() async -> [EKEvent]? {
        // Create the start date components
        var oneDayAgoComponents = DateComponents()
        oneDayAgoComponents.day = -1
        let oneDayAgo = calendar.date(byAdding: oneDayAgoComponents, to: Date(), wrappingComponents: false)
        // Create the end date components
        var oneWeekFromNowComponents = DateComponents()
        oneWeekFromNowComponents.year = +1
        let oneWeekFromNow = calendar.date(byAdding: oneWeekFromNowComponents, to: Date(), wrappingComponents: false)
        
        var predicate: NSPredicate? = nil
        if let anAgo = oneDayAgo, let aNow = oneWeekFromNow {
            predicate = eventStore.predicateForEvents(withStart: anAgo, end: aNow, calendars: nil)
        }
        
        if let aPredicate = predicate {
            events = eventStore.events(matching: aPredicate).filter{
                $0.location?.isEmpty == false
            }
        }
        return events
        
    }
    
}
