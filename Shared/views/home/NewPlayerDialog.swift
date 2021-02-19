//
//  NewPlayerDialog.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct NewPlayerDialog: View {
    @EnvironmentObject var playerModel: NetworkPlayerModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var show: ActiveSheet?
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
                    Button(action: { show = nil } ) {
                        Text("Close")
                    }
                    if showDetail{
                        Button(action: { playerModel.addPlayer(viewContext: viewContext, dotaPlayer: dotaPlayer){
                            show = nil
                        } }  ) {
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

