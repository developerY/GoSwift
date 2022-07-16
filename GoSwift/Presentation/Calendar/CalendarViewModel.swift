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
    @ObservedObject var calRepo = CalendarRepo()
    var events: [EKEvent]?
    
    init() {
        events = calRepo.loadEvents() ?? [EKEvent()]
    }
}
