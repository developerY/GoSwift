//
//  IocShakeBikeContainer.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//
// https://paulallies.medium.com/swift-dependency-injection-with-swinject-ad17e33c3910

import Foundation
import Swinject

func buildContainer() -> Container {
    let container = Container()
    
    container.register(SharedBikesDataSourceProtocol.self) { _ in
        return NetworkSharedBikesDataSource()
    }.inObjectScope(.container)
    
    container.register(BartStationsDataSourceProtocol.self) { _ in
        return BartStationsDataSource()
    }.inObjectScope(.container)
    
    
    container.register(WalkingRoutesDataSourceProtocol.self) { _ in
        return WalkingRoutesDataSource()
    }.inObjectScope(.container)
    
    container.register(CurrentCalEventDataSourceProtocol.self) { _ in
        return CurrentCalEventDataSource()
    }.inObjectScope(.container)
    
    container.register(SharedBikesRepositoryProtocol.self) { _ in
        return SharedBikesRepository(sharedBikesDataSource: container.resolve(SharedBikesDataSourceProtocol.self)!)
    }.inObjectScope(.container)
    
    container.register(BartStationsRepositoryProtocol.self) { _ in
        return BartStationsRepository(bartStationsDataSource: container.resolve(BartStationsDataSourceProtocol.self)!)
    }.inObjectScope(.container)
    
    container.register(WalkingRoutesRepositoryProtocol.self) { _ in
        return WalkingRoutesRepository(walkingRoutesDataSource: container.resolve(WalkingRoutesDataSourceProtocol.self)!)
    }.inObjectScope(.container)
    
    
    container.register(CurrentCalEventRepositoryProtocol.self) { _ in
        return CurrentCalEventRepository(currentCalEventDataSource: container.resolve(CurrentCalEventDataSourceProtocol.self)!)
    }.inObjectScope(.container)
    
    container.register(GetAllSharedBikesUseCaseProtocol.self) { _ in
        return GetAllSharedBikes(sharedBikesRepo: container.resolve(SharedBikesRepositoryProtocol.self)!)
    }.inObjectScope(.container)
    
    
    container.register(GetAllBartStationsUseCaseProtocol.self) { _ in
        return GetAllBartStations(bartStationRepo: container.resolve(BartStationsRepositoryProtocol.self)!)
    }.inObjectScope(.container)
    
    container.register(GetAllWalkingRoutesUseCaseProtocol.self) { _ in
        return GetAllWalkingRoutes(walkingRoutesRepo: container.resolve(WalkingRoutesRepositoryProtocol.self)!)
    }.inObjectScope(.container)
    
    container.register(GetCurrentCalEventUseCaseProtocol.self) { _ in
        return GetCurrentCalEvent(currentCalEventRepo: container.resolve(CurrentCalEventRepositoryProtocol.self)!)
    }.inObjectScope(.container)
    
    return container
}


// asyc -> network -> publisher -> SwiftUI (subscriber)
/*container.register(CorDataWrapperProtocl.self) { _ in
    return CoreDataWrapper)
}.inObjectScope(.container)*/
