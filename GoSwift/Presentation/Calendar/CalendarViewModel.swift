//
//  CalendarViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/12/22.
//

import Foundation
import EventKit
import EventKitUI


class CalendarViewModel: ObservableObject{
    var eventStore: EKEventStore
    
    init() {
        eventStore = EKEventStore()
    }
    
    func requestAccess() {
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    // load events
                }
            }
            
        }
    }
    
    
}
