//
//  MatchHistory.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchHistory: View {
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @EnvironmentObject var matchModel: MatchModel
    let playerId: String
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State var count = 0
    
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
            .onReceive(timer, perform: { time in
                if count > 0{
                    matchModel.findMatchByPlayer(playerId: playerId, pushNotification: true)
                    count += 1
                }
            })
            .onAppear{
                matchModel.findMatchByPlayer(playerId: playerId, pushNotification: false)
                count += 1
            }
    }
}

struct MatchHistory_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistory(playerId: "abc")
            .environmentObject(MockModel())
    }
}
