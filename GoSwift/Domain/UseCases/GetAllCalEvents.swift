//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation
import EventKit

class GetCalEvents : CalEventsUseCaseProtocol {

    private let getCalEventsRepo: CalEventsRepositoryProtocol
    init(getCalEventsRepo : CalEventsRepositoryProtocol) {
        self.getCalEventsRepo = getCalEventsRepo
    }
    
    // MARK: Get/Set current event
    func execute() async throws ->  [EKEvent]? {
        return try await getCalEventsRepo.getCalEvents()
    }
}
