//
//  DetailInfoPage.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI

struct DetailInfoPage: View {
    @State var selectedPlayer: PlayerMatch?
    
    let match: MatchDetails
    var body: some View {
        GeometryReader { m in
                HStack(alignment: .top) {
                    ScrollView{
                        HeroSelectionView(players: match.players ?? [], selectedPlayer: $selectedPlayer)
                        
                    }
                    .frame(maxWidth: 120, maxHeight: m.size.height)
                    ScrollView {
                        if let selectedPlayer = selectedPlayer{
                            VStack(alignment: .leading){
                                Text("Charts")
                                    .font(.title)
                                    .padding([.vertical])
                                Divider()
                                PlayerChartView(player: selectedPlayer)
                                
                                Text("Purchase Logs")
                                    .font(.title)
                                    .padding([.vertical])
                                Divider()
                                PurchaseLogView(purchaseLogs: selectedPlayer.purchaseLog ?? [])
                                   
                            }
                        }
                     
                    }
                    .padding()
                }
            
        }
    }
}

struct DetailInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfoPage(match: demoMatch)
            .environmentObject(HeroModel())
    }
}
