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
        let filtedChat = chats.filter{c in c.type == ChatEnum.chat.rawValue }
        List(0..<filtedChat.count){
            index -> ChatRow in
            let chat = filtedChat[index]
            
            return ChatRow(chat: chat, players: players)
        }
    }
}

struct ChatRow: View{
    let chat: Chat
    let players: [PlayerMatch]
    @State var showDetail = false
    
    var body: some View{
        let player = players.first{
            p in
            p.playerSlot == chat.playerSlot
        }
        let (hr, min, sec) = (chat.time ?? 0).secondsToHoursMinutesSeconds()
        
        var userExists: Bool{
            get {
                if let player = player{
                    if let _ = player.accountID{
                        return true
                    }
                }
                
                return false
            }
        }
        
        return
            
            VStack(alignment: .leading) {
                HStack{
                    Text("\(hr):\(min):\(sec)")
                    if userExists{
                        Text(chat.unit ?? "")
                            .underline()
                            .foregroundColor(player?.color)
                            .onTapGesture {
                                showDetail = true
                            }
                    } else{
                        Text(chat.unit ?? "")
                            .foregroundColor(player?.color)
                          
                    }
                    Text(chat.key ?? "ChatWheels")
                }
                Divider()
            }
            .popover(isPresented: $showDetail){
                if let player = player{
                    if let account = player.accountID{
                        AvatarView(playerId: String(account))
                    }
                }
            }
        }
    
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(chats: demoChats, players: [demoPlayer])
    }
}
