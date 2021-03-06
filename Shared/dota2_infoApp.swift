//
//  dota2_infoApp.swift
//  Shared
//
//  Created by 李其炜 on 2/17/21.
//

import SwiftUI

@main
struct dota2_infoApp: App {
    @StateObject var matchModel = MatchModel()
    @StateObject var heroModel = HeroModel()
    @StateObject var playerModel = NetworkPlayerModel()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(matchModel)
                .environmentObject(heroModel)
                .environmentObject(NetworkPlayerModel())
        }
    }
}
