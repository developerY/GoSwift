//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

class GetCurrentCalEvent : GetCurrentCalEventUseCaseProtocol {

    private let currentCalEventRepo: CurrentCalEventRepositoryProtocol
    init(currentCalEventRepo : CurrentCalEventRepositoryProtocol) {
        self.currentCalEventRepo = currentCalEventRepo
    }
    
    // MARK: Get/Set current event
    func execute() async throws ->  CurrentCalEvent {
        return try await currentCalEventRepo.getCurrentCalEvent()
    }
    
    func execute(myEvent: String, loc eventLoc: CLLocation) async throws {
        try await currentCalEventRepo.setCurrentCalEvent(myEvent: myEvent, loc: eventLoc)
    }

}
