//
//  SharedBikesSourceProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
import Combine
import CoreLocation

protocol CurrentCalEventDataSourceProtocol{
    func getCurrentCalEvent() async throws -> CurrentCalEvent
    func setCurrentCalEvent(myEvent: String, eventDate:Date, loc :CLLocation) async throws
}


