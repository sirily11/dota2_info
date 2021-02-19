//
//  NewPlayerDialog.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct NewPlayerDialog: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var show: Bool
    @State var playerId: String = ""
    @State var showDetail: Bool = false
    @State var dotaPlayer: DotaPlayer? = nil
    @State var isLoading = false
    
    var body: some View {
            VStack{
                if isLoading{
                    ProgressView()
                }
            
                if showDetail{
                    if let dotaPlayer = dotaPlayer{
                        NewPlayerDialogDetails(dotaPlayer: dotaPlayer)
                    } else{
                        Text("No Such User")
                            .padding(.all)
                            .frame(minWidth: 400)
                    }
                } else{
                    Text("Add Player")
                        .font(.subheadline)
                    TextField("Player ID", text: $playerId)
                }
               
                Spacer()
                HStack{
                    Button(action: { show = false } ) {
                        Text("Close")
                    }
                    if showDetail{
                        Button(action: addPlayer  ) {
                            Text("Add Player")
                        }
                    } else{
                        Button(action: search ) {
                                Text("Search")
                        }
                    }
                  
                }
            }
            .padding(.all)
            .frame(minWidth: 500)
        
       
    }
    
    
    private func addPlayer(){
        let newPlayer = Player(context: viewContext)
        if let accountID = dotaPlayer?.profile?.accountID{
            newPlayer.userid = Int64(accountID)
        }
        
        if let username = dotaPlayer?.profile?.personaname{
            newPlayer.username = username
        }
        
        if let avatar = dotaPlayer?.profile?.avatarfull{
            newPlayer.avatar = avatar
        }
        
        do{
            try viewContext.save()
            show = false
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    private func search(){
        isLoading = true
        
        let model = NetworkPlayerModel()
        model.fetchPlayer(playerID: playerId){
            player in
           
                dotaPlayer = player
                showDetail = true
                isLoading = false
            
        }
    }
}

