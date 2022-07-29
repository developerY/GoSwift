//
//  HealthInfoRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/28/22.
//

import Foundation
import EventKit

class CalEventsRepository : CalEventsRepositoryProtocol {
    private let calEventsDataSource: CalEventsDataSourceProtocol

    init(calEventsDataSource: CalEventsDataSourceProtocol){
        self.calEventsDataSource = calEventsDataSource
    }
    
    func getCalEvents() async throws -> [EKEvent]? {
        try await calEventsDataSource.getCalEvents()
    }

}
