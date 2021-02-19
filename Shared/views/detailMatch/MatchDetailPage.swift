//
//  MatchDetailPage.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchDetailPage: View {
    @EnvironmentObject var matchModel: MatchModel
    
    let matchId: Int
    let playerId: String
    @State var matchData: MatchDetails? = nil
    
    var body: some View {
        Group{
            if let matchData = matchData{
                MatchDetailView(match: matchData)
            } else {
                VStack{
                    ProgressView()
                    Text("Loading Match \(String(matchId))")
                }
          
            }
        }
        .onAppear{
            if matchData == nil{
                matchModel.findMatchDetailsById(matchId, playerID: playerId){
                    match in
                    withAnimation{
                        matchData = match
                    }
                }
            }
        }
        .navigationTitle(Text("Match"))
    }

}

struct MatchDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailPage(matchId: 5840322763, playerId: "205258988")
    }
}
