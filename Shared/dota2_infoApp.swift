//
//  dota2_infoApp.swift
//  Shared
//
//  Created by 李其炜 on 2/17/21.
//

import SwiftUI

@main
struct dota2_infoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
