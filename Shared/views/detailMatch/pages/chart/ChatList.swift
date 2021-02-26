//
//  ChatList.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI

struct ChatList: View {
    let chats: [Chat]
    let players: [PlayerMatch]
    
    var body: some View {
        List(0..<chats.count){
            index -> ChatRow in
           let chat = chats[index]
            
            return ChatRow(chat: chat, players: players)
        }
    }
}

struct ChatRow: View{
    let chat: Chat
    let players: [PlayerMatch]
    @State var showDetail = false
    
    var body: some View{
        let player = players[chat.slot ?? 0]
        let (hr, min, sec) = (chat.time ?? 0).secondsToHoursMinutesSeconds()
        
        return HStack{
            VStack{
                if(chat.type == ChatEnum.chat.rawValue){
                    Text(chat.unit ?? "")
                        .onTapGesture {
                            showDetail = true
                        }
                    Text("\(hr):\(min):\(sec)")
                }
            }
            Text(chat.key ?? "")
        }
        .popover(isPresented: $showDetail){
            AvatarView(playerId: String(player.accountID ?? 0))
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(chats: demoChats, players: [demoPlayer])
    }
}
