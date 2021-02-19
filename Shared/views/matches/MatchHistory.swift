//
//  MatchHistory.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchHistory: View {
    @EnvironmentObject var matchModel: MatchModel
    let playerId: String
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {

            VStack {
                List {
                    if matchModel.isLoadingMatches{
                        HStack(alignment: .center){
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                    ForEach(matchModel.matches){
                        match in
                        if let id = match.id{
                            NavigationLink(
                                destination: MatchDetailPage(matchId: id, playerId: playerId),
                                label: {
                                    MatchHistoryRow(match: match)
                                })
                        } else{
                            MatchHistoryRow(match: match)
                        }
                      
                        Divider()
                        
                    }
                }
                .navigationTitle(Text("Home"))
               
            }
            .onAppear{
                matchModel.findMatchByPlayer(playerId: playerId)
            }
    }
}

struct MatchHistory_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistory(playerId: "abc")
            .environmentObject(MockModel())
    }
}
