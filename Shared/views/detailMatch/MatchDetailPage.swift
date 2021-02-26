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
    @State var showDetail = false
    
    var body: some View {
        Group{
            if let matchData = matchData{
                
                ZStack {
                    TabView{
                        MatchDetailView(match: matchData){
                            match in
                            self.matchData = match
                        }
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                        
                        HistoryTablePage(match: matchData)
                            .tabItem {
                                Label("Details", systemImage: "magnifyingglass")
                            }
                        if matchData.isParsed{
                            Text("Chart")
                                .tabItem{
                                    Label("Chart", systemImage: "chart.bar.fill")
                                }
                            
                            Text("Damage")
                                .tabItem{
                                    Label("Damage", systemImage: "chart.bar.fill")
                                }
                            
                            Text("Purchase logs")
                                .tabItem{
                                    Label("Purchase logs", systemImage: "chart.bar.fill")
                                }
                        }
                        
                       
                    }
                    .transition(.slide)
                    .padding()
                    .navigationTitle(Text("Details"))
                    .opacity(showDetail ? 1: 0)
                    
                }
                
            } else{
                VStack{
                    ProgressView()
                    Text("Loading match: \(String(matchId))")
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
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                        withAnimation{
                            showDetail = true
                        }
                    }
                }
            }
        }
    }
    
}

struct MatchDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailPage(matchId: 5840322763, playerId: "205258988")
            .environmentObject(MatchModel())
    }
}
