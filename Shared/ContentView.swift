//
//  ContentView.swift
//  Shared
//
//  Created by 李其炜 on 2/17/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @State var showAddPlayerDialog: Bool = false
    @EnvironmentObject var matchModel: MatchModel

    var body: some View {
        NavigationView{
            PlayerSidebar()
            Text("No Player selected")
            Text("No match selected")
        }
        .sheet(isPresented: $showAddPlayerDialog) {
            NewPlayerDialog(show: $showAddPlayerDialog)
        }
        .toolbar {
            if let player = matchModel.selectedPlayer{
                Button(action: { matchModel.findMatchByPlayer(playerId: player) }, label: {
                                          Image(systemName: "arrow.clockwise")
                                      })
            }
         
            #if os(macOS)
            Button(action: toggleSidebar, label: {
                                      Image(systemName: "sidebar.left")
                                  })
            #endif
            
            #if os(iOS)
            EditButton()
            #endif

            Button(action: { showAddPlayerDialog = true } ) {
                Label("Add Player", systemImage: "plus")
            }
        }
    }
    
    private func toggleSidebar() {
           #if os(iOS)
           #else
           NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
           #endif
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
