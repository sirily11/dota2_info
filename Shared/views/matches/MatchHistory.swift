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
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search by Match ID", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            matchModel.findMatchById(searchText, playerID: playerId)
                        }).foregroundColor(.primary)

                      
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    
                    .cornerRadius(10.0)

                }
                .padding(.horizontal)
                
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
                                destination: MatchDetailPage(matchId: String(id), playerId: playerId),
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
