//
//  SharedBikeRepositoryProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
protocol SharedBikesRepositoryProtocol {
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}
