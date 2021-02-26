//
//  HeroSelectionView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroSelectionView: View {
    let players: [PlayerMatch]
    @Binding var selectedPlayer: PlayerMatch?
    
    
    var body: some View {
        VStack {
            Text("天辉")
                .font(.title3)
            ForEach(0..<5){
                index -> HeroSelectionCell in
                let player = index < players.count ? players[index] : nil
                return HeroSelectionCell(selectedPlayer: $selectedPlayer, player: player)
            }
            Text("夜魇")
                .font(.title3)
            ForEach(5..<10){
                index -> HeroSelectionCell in
                let player = index < players.count ? players[index] : nil
               return HeroSelectionCell(selectedPlayer: $selectedPlayer, player: player)
            }
        }
    }
}

struct HeroSelectionCell: View {
    @Binding var selectedPlayer: PlayerMatch?
    @EnvironmentObject var heroModel: HeroModel
    let player: PlayerMatch?
    
    
    var body: some View {
        let hero = heroModel.findHeroById(String(player?.heroID ?? 0), with: [])
        
    
        return HStack(alignment: .center){
            if(selectedPlayer?.id == player?.id){
                WebImage(url: URL(string: hero?.heroData.img?.getAssetURL() ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .padding(.all, 4.0)
                    .background(Color.blue)
            } else{
                WebImage(url: URL(string: hero?.heroData.img?.getAssetURL() ?? ""))
                    .resizable()
                    .padding(.all, 4.0)
                    .aspectRatio(contentMode: .fit)
                    .frame( height: 60)
                    
            }
        }
        .frame(width: 120)
        .onTapGesture {
            withAnimation{
                selectedPlayer = player
            }
        }
    }
}

//struct HeroSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeroSelectionView(players: [demoPlayer], selectedPlayer: <#Binding<PlayerMatch?>#>)
//            .environmentObject(HeroModel())
//    }
//}
