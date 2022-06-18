//
//  SharedBikesResponseModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation

struct SharedBikesResponseModel: Identifiable, Equatable, Hashable {
    let id: UUID
    var location: String
    
    init() {
        id = UUID()
        location = ""
    }
}

struct SharedBikesRequestModel: Equatable {
    var location: String
    
    init() {
        location = ""
    }
    
    init(location: String) {
        self.location = location
    }
}
