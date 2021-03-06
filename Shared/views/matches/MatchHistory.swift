//
//  MatchHistory.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchHistory: View {
    @State var timer: Timer? = nil
    @EnvironmentObject var matchModel: MatchModel
    let playerId: String?
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
           
            .onAppear{
                matchModel.findMatchByPlayer(playerId: playerId)
                if let playerId = playerId{
                    timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (t) in
                        matchModel.fetchAndPushNotification(playerId: playerId)
                    }
                }
                
            }
            .onDisappear{
                timer?.invalidate()
            }
    }
}

struct MatchHistory_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistory(playerId: "abc")
            .environmentObject(MatchModel())
    }
}
