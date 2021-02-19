//
//  MatchDetailView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchDetailView: View {
    let match: MatchDetails

    
    var body: some View {
        ScrollView{
            HStack{
                Text("比赛详情")
                    .font(.title)
                Spacer()
            }
            .padding()
            
            VStack(alignment: .leading){
                InfoCard(match: match)
                    .padding()
                    .cornerRadius(10)
                          .overlay(
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                          )
                          .padding([.top, .horizontal])
                
                
                Section(header: Text("天辉").padding(.horizontal, 15.0).padding(.vertical, 5).background(Color.green) ){
                    if let players = match.players{
                        ForEach(players.filter{ player in player.isRadiant! } ){
                            player in
                            
                            DetailPlayerRow(player: player)
                        }
                    }
                   
                }
        
                
                Section(header: Text("夜餍").padding(.horizontal, 15.0).padding(.vertical, 5).background(Color.red)){
                    if let players = match.players{
                        ForEach(players.filter{ player in !player.isRadiant! } ){
                            player in
                            
                            DetailPlayerRow(player: player)
                        }
                    }
                   
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}



struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(
            match: demoMatch)
            .environmentObject(MatchModel())
            .environmentObject(HeroModel())
    }
}

