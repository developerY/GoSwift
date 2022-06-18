//
//  GetAllBikesUseCaseProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
protocol GetAllSharedBikesUseCaseProtocol {
    func execute() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}
