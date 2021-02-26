//
//  MatchDetailView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI

struct MatchDetailView: View {
    @EnvironmentObject var matchModel : MatchModel
    let match: MatchDetails
    @State var isLoading = false
    let updateDetail: (MatchDetails) -> Void
    
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("比赛详情")
                        .font(.title)
                    Button(action: refreshMatch)
                    {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    if !match.isParsed{
                        Button(action: parseMatch){
                            Text("Parse the match")
                        }
                    }
                    
                    if isLoading{
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .padding()
                
                InfoCard(match: match)
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
                
                HStack{
                    Spacer()
                    if let link = match.replayURL{
                        if let url = URL(string: link){
                            Link("Replay click here", destination: url )
                        } else{
                            Text(link)
                        }
                        
                    }
                    Spacer()
                }
                
                
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
            .padding(.all)
        }
    }
}

extension MatchDetailView{
    func refreshMatch(){
        isLoading = true
        matchModel.findMatchDetailsById(String(match.matchID ?? 0), playerID: matchModel.selectedPlayer, forceFetch: true)
        { (details) in
            updateDetail(details)
            isLoading = false
        }
    }
    
    func parseMatch(){
        isLoading = true
        if let matchId = match.matchID{
            matchModel.sendParseRequest(matchId: String(matchId)){
                jobId in
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true){
                    timer in
                    matchModel.getParseStatus(jobId: String(jobId)){
                        finished in
                        if finished{
                            timer.invalidate()
                            refreshMatch()
                        }
                        
                    }
                }
            }
        }
        
    }
}


struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(
            match: demoMatch){
            match in
            
        }
            .previewLayout(.device)
            .environment(\.sizeCategory, .extraLarge)
            .environmentObject(MatchModel())
            .environmentObject(HeroModel())
    }
}

