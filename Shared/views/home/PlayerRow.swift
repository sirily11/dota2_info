//
//  PlayerRow.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import Kingfisher

struct PlayerRow: View {
    @State var showInfo = false
    @State var isLoading = false
    @State var dotaPlayer: DotaPlayer? = nil
    @Environment(\.managedObjectContext) private var viewContext
    let player: Player
    
    var body: some View {
        NavigationLink(
            destination: MatchHistory(playerId: "\(player.userid)")
            ) {
            HStack{
                if player.avatar != nil{
                    KFImage(URL(string: player.avatar!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                }
            
                Text("\(player.username ?? "abc")")
            }
                
        }
        .contextMenu(ContextMenu(menuItems: {
            Button("Show Info"){
               fetchDotaPlayer()
            }
            Button("Delete"){
                deletePlayer(player: player)
            }
            
        }))
    
        .popover(isPresented: $showInfo, content: {
            PopoverView(isLoading: $isLoading, dotaPlayer: $dotaPlayer)
          
    })
    }
    
    private func fetchDotaPlayer(){
        isLoading = true
        showInfo = true
        let model = NetworkPlayerModel()
        model.fetchPlayer(playerID: "\(player.userid)"){
            player in
            withAnimation{
                isLoading = false
                dotaPlayer = player
            }
        }
    }
    
    private func deletePlayer(player: Player){
        withAnimation{
            viewContext.delete(player)
            
            do {
                try viewContext.save()
            } catch {
            
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}


struct PopoverView: View {
    @Binding var isLoading: Bool
    @Binding var dotaPlayer:DotaPlayer?
    
    var body: some View {
        if isLoading{
            ProgressView()
                .padding(.all)
        } else{
            if let dotaPlayer  = dotaPlayer{
                NewPlayerDialogDetails(dotaPlayer: dotaPlayer)
                    .frame(width: 400, height: 300)
                    .padding()
            } else {
                EmptyView()
            }
        }
    }
    
  
    
}
