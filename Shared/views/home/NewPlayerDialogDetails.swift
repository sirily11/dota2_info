//
//  NewPlayerDialogDetails.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import Kingfisher

struct NewPlayerDialogDetails: View {
    var dotaPlayer: DotaPlayer


    var body: some View {
        VStack{
            HStack{
                if let profile = dotaPlayer.profile?.avatarfull{
                    KFImage(URL(string: profile)!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        
                }
            }
            Text("\(dotaPlayer.profile?.personaname ?? "匿名用户")")
                .font(.title)
            Form{
                Section(header: Text("User Info")){
                    HStack {
                           Text("User Name")
                           Spacer()
                        Text("\(dotaPlayer.profile?.personaname ?? "Empty")")
                       }
                    
                    HStack {
                           Text("Dota Plus")
                           Spacer()
                        Text("\( (dotaPlayer.profile?.plus ?? false) ? "True" : "False" ) ")
                       }
                }
                #if os(macOS)
                Divider()
                #endif
                
                Section(header: Text("MMR")){
                    HStack {
                           Text("MMR estimate")
                           Spacer()
                        Text("\(dotaPlayer.mmrEstimate?.estimate ?? 0)")
                       }
                    
                    HStack {
                           Text("MMR Rank")
                           Spacer()
                        Text("\(dotaPlayer.soloCompetitiveRank ?? 0)")
                       }
                }
            }
        }
    }

}

struct NewPlayerDialogDetails_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerDialogDetails(dotaPlayer: DotaPlayer( soloCompetitiveRank: nil, competitiveRank: nil,  rankTier: nil, leaderboardRank: nil, mmrEstimate: nil, profile: Profile(accountID: 2055, personaname: "Bard+++++", name: nil, plus: true, cheese: nil, steamid: nil, avatar: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f3/f3290d49e20dbd8f02d5920f7485bd777fdb3f33.jpg", avatarmedium: nil, avatarfull: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f3/f3290d49e20dbd8f02d5920f7485bd777fdb3f33_full.jpg", profileurl: nil, lastLogin: nil, loccountrycode: nil, isContributor: false)) )
    }
}
