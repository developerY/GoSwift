//
//  GetAllSharedBikes.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
class GetAllSharedBikes : GetAllSharedBikesUseCaseProtocol {
    
    private let sharedBikesRepo: SharedBikesRepositoryProtocol
    
    init(sharedBikesRepo : SharedBikesRepositoryProtocol) {
        self.sharedBikesRepo = sharedBikesRepo
    }
    
    func execute() async -> Result<[SharedBikesResponseModel], SharedBikesError> {
        return await sharedBikesRepo.getAllSharedBikes()
    }
}
