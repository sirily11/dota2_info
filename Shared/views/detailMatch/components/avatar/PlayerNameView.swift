//
//  PlayerNameView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/22/21.
//

import SwiftUI

struct PlayerNameView: View {
    let player: PlayerMatch
    let normalFont: Bool
    @State var showDetail = false
    
    var body: some View {
        Group{
            if !normalFont {
                Text(player.personaname ?? "匿名玩家")
                    .lineLimit(2)
                    .foregroundColor(Color.red)
                    .font(.title)
            } else{
                Text(player.personaname ?? "匿名玩家")
                    .lineLimit(2)
            }
        }
        .onTapGesture {
            showDetail = true && player.accountID != nil
        }
        .popover(isPresented: $showDetail, content: {
            Group{
                if let accountId = player.accountID{
                    AvatarView(playerId: String(accountId))
                }
            }
        })
     
         
    }
}
