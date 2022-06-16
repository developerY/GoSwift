//
//  GoSwiftApp.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/15/22.
//

import SwiftUI

@main
struct GoSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
