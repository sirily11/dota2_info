//
//  DetailPlayerRow.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import Kingfisher

struct DetailPlayerRow: View {
    @EnvironmentObject var heroModel: HeroModel
    var player: PlayerMatch
    @State var showDetails = false
    @State var showUserDetails = false
    
    var body: some View {
        let hero = heroModel.findHeroById(String(player.heroID!), with: [player.item0, player.item1, player.item2, player.item3, player.item4, player.item5, player.backpack0, player.backpack1, player.backpack2, ])
        
        return Group{
            if let hero = hero{
                 VStack{
                    HStack(alignment: .top){
                        ZStack(alignment: .bottomTrailing){
                            KFImage(URL(string: hero.heroData.img!.getAssetURL()))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 60)
                            Text(String(Int(player.level  ?? 0)))
                                .padding(4)
                                .background(Color.blue)
                                .offset(x: 0, y: 0)
                                
                        }

                        
                        VStack(alignment: .leading){
                            Text(player.personaname ?? "匿名玩家")
                                .lineLimit(2)
                                .foregroundColor(Color.red)
                                .font(.title)
                                .onTapGesture {
                                    showUserDetails = true && player.accountID != nil
                                }
                                .popover(isPresented: $showUserDetails, content: {
                                    Group{
                                        if let accountId = player.accountID{
                                            AvatarView(playerId: String(accountId))
                                        }
                                    }
                                })

                            
                            Text(hero.heroData.localizedName!)
                                .bold()
                            
                            
                            Text("\(player.kills ?? 0) / \(player.deaths ?? 0 ) / \(player.assists ?? 0)")
                            
                            Text("DMG: \(String(player.heroDamage ?? 0))")
                            
                            Text("GOLD: \(String(player.netWorth ?? 0))")
                        }
                        
                        Spacer()
                        ItemGrid(items: hero.items)
                            .padding(.trailing)
                        

                      
                    }
                    .padding()
                    // hidden contents
                    if showDetails{
                        Group{
                            HStack{
                                Text("Skills Upgrade")
                                    .font(.title)
                                Spacer()
                            }
                            .padding()
                            
                            SkillsUpgrade(player: player)
                                .padding()
                            
                            HStack{
                                Text("Tower Damage")
                                Spacer()
                                Text(String(player.towerDamage ?? 0))
                            }
                            .padding(.horizontal, 10)
                            
                            HStack{
                                Text("治疗")
                                Spacer()
                                Text(String(player.heroHealing ?? 0))
                            }
                            .padding(.horizontal, 10)
                            HStack{
                                Text("Last Hits")
                                Spacer()
                                Text(String(player.lastHits ?? 0))
                            }
                            .padding(.horizontal, 10)
                            HStack{
                                Text("XP per min")
                                Spacer()
                                Text(String(player.xpPerMin ?? 0))
                            }
                            .padding(.horizontal, 10)
                            
                            HStack{
                                Text("Gold per min")
                                Spacer()
                                Text(String(player.goldPerMin ?? 0))
                            }
                            .padding(.horizontal, 10)
                            
                            HStack{
                                Text("Gold remaining")
                                Spacer()
                                Text(String(player.gold ?? 0))
                            }
                            .padding(.horizontal, 10)
                            
                        }
                      
                    }
                    
                    
                    // end hidden contents
                    
                    Button(action: { withAnimation{self.showDetails.toggle() } }){
                        HStack{
                            Spacer()
                            Image(systemName: !self.showDetails ? "chevron.down" : "chevron.up")
                                .font(.title)
                          
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
                 
            } else{
                 EmptyView()
            }
            
            
        }
        
        .cornerRadius(10)
        
          .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: showDetails ? 0.4 : 0), lineWidth: 1)
          )
        
        
        
    }
    
    
}

struct DetailPlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlayerRow(player: demoMatch.players![0] )
            .environmentObject(HeroModel())
    }
}
