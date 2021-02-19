//
//  PlayerSidebar.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI



struct PlayerSidebar: View {
    

    @EnvironmentObject var playerModel : NetworkPlayerModel
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.timestamp, ascending: true)],
        animation: .default)
    private var players: FetchedResults<Player>
    
    var body: some View {
        List{
            Text("Players")
            ForEach(players){
             player in
                PlayerRow(player: player)
               
            }
            .onDelete{ indexSet in
                playerModel.deletePlayers(viewContext: viewContext, offsets: indexSet, players: players)
            }
        }
        
       
    }
    
}

struct PlayerSidebar_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSidebar().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(NetworkPlayerModel())
    }
}
