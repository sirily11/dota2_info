//
//  ContentView.swift
//  Shared
//
//  Created by 李其炜 on 2/17/21.
//

import SwiftUI
import CoreData

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}


struct ContentView: View {
    @State var showSheet : ActiveSheet? {
        didSet{
            if showSheet == nil{
                searchedMatch = nil
            }
        }
    }
    @EnvironmentObject var matchModel: MatchModel
    @State var text = ""
    @State var searchedMatch: MatchDetails?
    @State var isLoading = false
    
    
    var body: some View {
        NavigationView{
            PlayerSidebar()
            Text("No Player selected")
            Text("No match selected")
        }
        .sheet(item: $showSheet){
            sheet in
            switch sheet{
            case .first:
                NewPlayerDialog(show: $showSheet)
            case .second:
                Group{
                    VStack{
                        if let match = searchedMatch{
                            MatchDetailView(match: match){
                                match in
                                self.searchedMatch = match
                            }
                        } else{
                            Text("Match Not Found")
                        }
                        Button(action: { showSheet = nil }){
                            Text("Close")
                        }
                    }
                }
                .frame(width: 600, height: 600, alignment:  .center)
                .padding()
            }
        }
        .toolbar {
            // Search view
            HStack {
                ZStack(alignment: .trailing) {
                    ZStack {
                        TextField("Match ID", text: $text)
                        .font(.system(size: 12.0))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 280)
                    }
                    Button(action: search, label: {
                        Label("Search", systemImage: "magnifyingglass")
                    })
                    
                }
                
                if isLoading{
                    ProgressView()
                        .frame(width: 20, height: 20, alignment:  .center)
                }
                
            }
            
            
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
            
            Button(action: { showSheet = .first } ) {
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

extension ContentView{
    func search(){
        if !text.isEmpty{

            withAnimation{
                isLoading = true
            }
            matchModel.findMatchDetailsById(text, playerID: matchModel.selectedPlayer){
                match in
                searchedMatch = match
                showSheet = .second
                withAnimation{
                    isLoading = false
                }

            }

        }
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
