//
//  DamagePage.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI

struct DamagePage: View {
    let match: MatchDetails
    @State var selectedPlayer: PlayerMatch?
    
    var body: some View {
        GeometryReader { m in
            HStack(alignment: .top){
                ScrollView{
                    HeroSelectionView(players: match.players ?? [], selectedPlayer: $selectedPlayer)
                    
                }
                .frame(maxWidth: 120, maxHeight: m.size.height)
                if let selectedPlayer = selectedPlayer{
                    DamageTable(selectedPlayer: selectedPlayer, players: match.players ?? [])
                        .frame(maxWidth: m.size.width * 0.85, maxHeight: m.size.height)
                } else{
                    Spacer()
                }
            }
        }
    }
}

struct DamagePage_Previews: PreviewProvider {
    static var previews: some View {
        DamagePage(match: demoMatch)
            .environmentObject(HeroModel())
    }
}
