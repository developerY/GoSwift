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
    
    /*container.register(CorDataWrapperProtocl.self) { _ in
        return CoreDataWrapper)
    }.inObjectScope(.container)*/
    
    container.register(GetAllSharedBikesUseCaseProtocol.self) { _ in
        return GetAllSharedBikes(sharedBikesRepo: container.resolve(SharedBikesRepositoryProtocol.self)!)
    }.inObjectScope(.container)
    
    return container
    
    
}
