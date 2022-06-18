//
//  SharedBikesRepository.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation

class SharedBikesRepository : SharedBikesRepositoryProtocol{
    
    private let sharedBikesDataSource: SharedBikesDataSourceProtocol
    
    init(sharedBikesDataSource: SharedBikesDataSourceProtocol){
        self.sharedBikesDataSource = sharedBikesDataSource
    }
    
    func getAllSharedBikes() async -> Result<[SharedBikesResponseModel], SharedBikesError> {
        return await sharedBikesDataSource.getAll()
    }
    

}
