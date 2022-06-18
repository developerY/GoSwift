//
//  SharedBikesSourceProtocol.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//

import Foundation
protocol SharedBikesDataSourceProtocol{
    func getAll() async -> Result<[SharedBikesResponseModel], SharedBikesError>
}
