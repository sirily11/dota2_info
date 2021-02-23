//
//  HeroAvatar.swift
//  dota2_info
//
//  Created by 李其炜 on 2/20/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroAvatar: View {
    @State var showDetail = false
    let player: PlayerMatch
    let hero: MatchHero
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            if let img = hero.heroData.img{
                LazyVStack{
                    WebImage(url: URL(string: img.getAssetURL()))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 
                }
                .frame(width: 100, height: 60)
            }
          
            Text(String(Int(player.level  ?? 0)))
                .padding(4)
                .background(Color.blue)
                .offset(x: 0, y: 0)
                
        }
        .onTapGesture {
            showDetail = true
        }
        .popover(isPresented: $showDetail, content: {
            HeroInfoView(hero: hero)
        })
    }
}

struct HeroInfoView: View {
    let hero: MatchHero
    
    
    var body: some View {
        VStack{
            if let img = hero.heroData.img{
                WebImage(url: URL(string: img.getAssetURL()))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 100)
            }
            
            Text(hero.heroData.localizedName ?? "No such hero")
            Divider()
            Section(header: Text("Basic Info")){
                HStack{
                    Text("Base HP")
                    Spacer()
                    Text(String(hero.heroData.baseHealth ?? 0))
                }
                HStack{
                    Text("Base Mana")
                    Spacer()
                    Text(String(hero.heroData.baseMana ?? 0))
                }
                HStack{
                    Text("Base Damage")
                    Spacer()
                    Text("\(String(hero.heroData.baseAttackMin ?? 0)) ~  \(String(hero.heroData.baseAttackMax ?? 0))")
                }
                
                HStack{
                    Text("Base Armor")
                    Spacer()
                    Text(String(hero.heroData.baseArmor ?? 0))
                }
                
                HStack{
                    Text("Base Intelligence")
                    Spacer()
                    Text(String(hero.heroData.baseInt ?? 0))
                }
                
                HStack{
                    Text("Base strength")
                    Spacer()
                    Text(String(hero.heroData.baseStr ?? 0))
                }
                
                HStack{
                    Text("Base agility")
                    Spacer()
                    Text(String(hero.heroData.baseAgi ?? 0))
                }
            }
            
            Divider()
            
            Section(header: Text("More Info")){
                HStack{
                    Text("Strength gain")
                    Spacer()
                    Text(String(hero.heroData.strGain ?? 0))
                }
                
                HStack{
                    Text("Intelligence gain")
                    Spacer()
                    Text(String(hero.heroData.intGain ?? 0))
                }
                
                HStack{
                    Text("Agility gain")
                    Spacer()
                    Text(String(hero.heroData.agiGain ?? 0))
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 400, height: 500, alignment:  .center)
    }
}



struct HeroAvatar_Previews: PreviewProvider {

    
    static var previews: some View {
        let hero = MatchHero(items: [], ability: [], heroData: DotaHero(id: 1, name: "a", localizedName: "abc", primaryAttr: "", attackType: "a", roles: [], img: "/apps/dota2/images/heroes/alchemist_full.png", icon: "/apps/dota2/images/heroes/alchemist_full.png", baseHealth: 120, baseHealthRegen: 100, baseMana: 120, baseManaRegen: 100, baseArmor: 1, baseMr: 120, baseAttackMin: 120, baseAttackMax: 120, baseStr: 10, baseAgi: 120, baseInt: 120, strGain: 120, agiGain: 120, intGain: 120, attackRange: 120, projectileSpeed: 120, attackRate: 120, moveSpeed: 120, turnRate: 120, cmEnabled: true, legs: 4))
        
        Group {
            HeroAvatar(player: demoMatch.players![0], hero: hero)
                .environmentObject(HeroModel())
            HeroInfoView(hero: hero)
                .environmentObject(HeroModel())
        }
    }
}
