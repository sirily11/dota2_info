//
//  HistoryTablePage.swift
//  dota2_info
//
//  Created by 李其炜 on 2/21/21.
//

import SwiftUI

struct HistoryTablePage: View {
    @EnvironmentObject var heroModel: HeroModel
    let match: MatchDetails
    
    let emptyHero = MatchHero(items: [], ability: [], heroData: DotaHero(id: 0, name: "", localizedName: "", primaryAttr: "", attackType: "", roles: [], img: nil, icon: nil, baseHealth: 0, baseHealthRegen: 0, baseMana: 0, baseManaRegen: 0, baseArmor: 0, baseMr: 0, baseAttackMin: 0, baseAttackMax: 0, baseStr: 0, baseAgi: 0, baseInt: 0, strGain: 0, agiGain: 0, intGain: 0, attackRange: 0, projectileSpeed: 0, attackRate: 0, moveSpeed: 0, turnRate: 0, cmEnabled: false, legs: 0))
    
    var body: some View {
        let totalDmg1 = match.players?.filter{player in player.isRadiant ?? true }.reduce(0, { (prev, current) -> Double in
            prev + (current.heroDamage ?? 0)
        }) ?? 1
        
        let totalDmg2 = match.players?.filter{player in !(player.isRadiant ?? true) }.reduce(0, { (prev, current) -> Double in
            prev + (current.heroDamage ?? 0)
        }) ?? 1
        
        let columns: [DataColumn] = [
            DataColumn(sortKey: "Hero", content: AnyView(Text(""))),
            DataColumn(sortKey: "Hero", content: AnyView(Text("阵营"))),
            DataColumn(sortKey: "PlayerName", content: AnyView(Text("Player Name"))),
            DataColumn(sortKey: "Items", content: AnyView(Text("Items"))),
            DataColumn(sortKey: "Level", content: AnyView(Text("Level"))),
            DataColumn(sortKey: "Gold", content: AnyView(Text("Gold"))),
            DataColumn(sortKey: "Gold", content: AnyView(Text("Gold Remaining"))),
            DataColumn(sortKey: "Damage", content: AnyView(Text("Damage"))),
            DataColumn(sortKey: "Damage", content: AnyView(Text("Damage Percentage"))),
            DataColumn(sortKey: "Tower", content: AnyView(Text("Tower Damage"))),
            DataColumn(sortKey: "Skills", content: AnyView(Text("Skills")))
        ]
        
        let rows: [DataRow] = (match.players ?? []).enumerated().map{
            (index, player) in
            let hero: MatchHero? = heroModel.findHeroById(String(player.heroID!), with: [player.item0, player.item1, player.item2, player.item3, player.item4, player.item5, player.backpack0, player.backpack1, player.backpack2, ])
            
            let percentage = index < 6 ? ((player.heroDamage ?? 1) / totalDmg1) :  ((player.heroDamage ?? 1) / totalDmg2)
            
            return DataRow(sortKey: "",
                           cells: [
                            DataRowCell(content:  AnyView(HeroAvatar(player: player, hero: hero ?? emptyHero)), width: 100),
                            DataRowCell(content:  AnyView(Text(index < 6 ? "天辉" : "夜魇"))),
                            DataRowCell(content:  AnyView(Text(player.personaname ?? "匿名玩家"))),
                            DataRowCell(content:  AnyView(ItemGrid(items: hero?.items ?? [])), width: 200),
                            DataRowCell(content:  AnyView(Text(String(player.level ?? 0)))),
                            DataRowCell(content:  AnyView(Text(String(player.netWorth ?? 0)))),
                            DataRowCell(content:  AnyView(Text(String(player.gold ?? 0)))),
                            DataRowCell(content:  AnyView(Text(String(player.heroDamage ?? 0)))),
                            DataRowCell(content:  AnyView(Text("\(String(round(percentage * 100))) %"))),
                            DataRowCell(content:  AnyView(Text(String(player.towerDamage ?? 0)))),
                            DataRowCell(content:  AnyView(SkillsUpgrade(player: player)), width: 350),
                           ],
                           height: 140
            )
        }
        
        return DataGridView(dataGrid: DataGrid(columns: columns, rows: rows)).padding()
    }
}

struct HistoryTablePage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTablePage(match: demoMatch)
            .environmentObject(HeroModel())
    }
}
