//
//  SkillsUpgrade.swift
//  dota2_info
//
//  Created by 李其炜 on 2/19/21.
//

import SwiftUI
import Kingfisher

let minimumWidth: CGFloat = 120

struct SkillsUpgrade: View {
    @EnvironmentObject var heroModel : HeroModel
    let player: PlayerMatch

    let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: rows){
            if let upgradeArr = player.abilityUpgradesArr{
                ForEach(0..<upgradeArr.count){
                    index -> SkillsImage in
                    let skill = heroModel.findAbilityById(id: String(upgradeArr[index]))
                    
                    return SkillsImage(skill: skill)
                }
            }
          
        }

    }
}

struct SkillsImage: View {
    let skill: Ability?
    @State var showDetail = false
    
    var body: some View {
        Group{
            if let img = skill?.img{
                KFImage(URL(string: img.getAssetURL())!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        showDetail = true
                    }
                    .popover(isPresented: $showDetail, content: {
                        SkillsDetail(skill: skill!)
                            .padding()
                            .frame(width: 300)
                    })
            
                
            } else{
                EmptyView()
            }
        }
    
    }
}

struct SkillsDetail: View {
    let skill: Ability
    
    var body: some View {
        VStack{
            if let img = skill.img{
                KFImage(URL(string: img.getAssetURL())!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            }
           
            Text(skill.dname!)
                .font(.title)
            Divider()
            HStack{
                Text("Damage Type")
                Spacer()
                Text(skill.dmgType ?? "")
            }
            HStack{
                Text("Description")
                Spacer()
                Text(skill.desc ?? "")
            }
        }
    }
}




struct SkillsUpgrade_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SkillsUpgrade(player: demoMatch.players![0])
                .environmentObject(HeroModel())
            SkillsDetail(skill: Ability(dname: "abc", dmgType: "magic", bkbpierce: nil, desc: "Some thing", img: "/apps/dota2/images/abilities/antimage_spell_shield_md.png") )
                .environmentObject(HeroModel())
        }
    }
}
