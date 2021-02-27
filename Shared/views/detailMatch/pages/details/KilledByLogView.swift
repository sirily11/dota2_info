//
//  KilledByLogView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Record: Identifiable{
    let id=UUID()
    var name: String
    var count: Int
}

struct KilledByLogView: View {
    let player: PlayerMatch
    let columns = [GridItem(.adaptive(minimum: 40, maximum: 150))]
    
    var body: some View {
        var items: [Record] = []
            
        player.killedBy?.forEach{
            key, value in
            items.append(Record(name: key, count: value))
        }
        
        
        return LazyVGrid(columns: columns){
            ForEach(items){
                record -> KilledByCell in
                
                return KilledByCell(name: record.name, count: record.count)
                
            }
        }
    }
}

struct KilledByCell: View{
    @EnvironmentObject var heroModel: HeroModel
    let name: String
    let count: Int
    @State var showDetail = false
    
    var body: some View {
        let hero = heroModel.findHeroByName(heroName: name, with: [])
        
        return VStack{
            if let hero = hero{
                WebImage(url: URL(string: hero.heroData.icon?.getAssetURL() ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        showDetail = true
                    }
                    .popover(isPresented: $showDetail, content: {
                        HeroInfoView(hero: hero)
                    })
                    
            } else{
                Text(name)
            }
            Text("\(String(count))")
        }
        .frame(width: 40, height: 60, alignment: .center)
    }
}

struct KilledByLogView_Previews: PreviewProvider {
    static var previews: some View {
        KilledByLogView(player: demoPlayer)
            .environmentObject(HeroModel())
    }
}
