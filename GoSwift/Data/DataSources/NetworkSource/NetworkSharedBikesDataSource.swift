//
//  NetworkSharedBikesDataSource.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
class NetworSharedBikesDataSource : SharedBikesDataSourceProtocol {
    func getAll() async -> Result<[SharedBikesResponseModel], SharedBikesError> {
        <#code#>return Result([SharedBikesResponseModel()]
    }
    
    
    
    //private func mapToSharedBikesResponse(sharedBikesEntity: SharedBikesEntity) -> ShredBikesResponseModel{}
    
    private func getAll() -> [SharedBikesResponseModel] {
        return [SharedBikesResponseModel()]
    }
    
    
    
    
    /*func getAllMap() async -> Result<[SharedBikesResponseModel], SharedBikesError> {
        do{
            let data = try _getAll()
            return .success(data.map({ contactEntity in
                [SharedBikesResponseModel()]//_getAll()
            }))
        }catch{
            return .failure(.Get)
        }    }*/
    
    

}
