//
//  avatarView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    let playerId: String
    @State var player: DotaPlayer?
    
    var body: some View {
        Group{
            if let player = player{
              
                 
                NewPlayerDialogDetails(dotaPlayer: player)
                    
                
            } else{
                ProgressView()
                
            }
        
            }
            .padding()
            .frame(width: 400 )
            .onAppear{
                getUserById()
            }
    }
    
    func getUserById(){
        let model = NetworkPlayerModel()
        model.fetchPlayer(playerID: playerId){
            player in
            withAnimation{
                self.player = player
            }
        }
    }
}

struct avatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(playerId: "205258988")
    }
}
