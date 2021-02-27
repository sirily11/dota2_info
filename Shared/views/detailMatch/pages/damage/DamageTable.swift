//
//  DamageTable.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI

struct DamageTable: View {
    @EnvironmentObject var heroModel: HeroModel
    let selectedPlayer: PlayerMatch
    let players: [PlayerMatch]
    
    var body: some View {
        let rowWidth = 120
        let heroes: [MatchHero?] = players.filter{p in p.isRadiant != selectedPlayer.isRadiant}.map{
            p in
            let hero = heroModel.findHeroById(String(p.heroID ?? 0), with: [])
            return hero
        }
        
        // Columns
        var columns: [DataColumn] = [DataColumn(sortKey: "Skill", content: AnyView(Text("")))]
        
        heroes.enumerated().forEach{
            i, hero in
                let player = players.first{p in p.heroID == hero?.heroData.id}
            
            if let player = player{
                let column =  DataColumn(sortKey: String(hero!.heroData.id ?? 0), content: AnyView(HeroAvatar(player: player, hero: hero!)))
                columns.append(column)
            }
        }
        
        columns.append(DataColumn(sortKey: "total", content: AnyView(Text("Total"))))
        
        // end columns
        // rows
        
        var rows: [DataRow] = []
        
        selectedPlayer.damageTargets?.sorted(by: { (prev, cur) -> Bool in
            let pkey = prev.key == "null" ? "a" : prev.key
            let ckey = cur.key == "null" ? "a" :cur.key
            
            return pkey < ckey
        }).forEach{
            skillName, targets in
            
            let skill = heroModel.findAbility(abilityName: skillName)
            
            var targetHeroes: [DataRowCell] = []
            
            if let skill = skill{
                targetHeroes.append( DataRowCell(content: AnyView(SkillsImage(skill: skill).frame(width: 80)), width: rowWidth))
            } else{
                if let item = heroModel.findItemByName(itemName: skillName){
                    targetHeroes.append(DataRowCell(content: AnyView(ItemCeil(item: item).frame(width: 80)), width: rowWidth))
                } else{
                    targetHeroes.append(DataRowCell(content: AnyView(Text(skillName == "null" ? "普通攻击" : skillName)), width: rowWidth))
                }
            
            }
            
            heroes.forEach{
                hero in
                
                let damage = targets[(hero?.heroData.name ?? "")]
                let cell = DataRowCell(content: AnyView(Text("\(String(damage ?? 0))")), width: rowWidth)
                targetHeroes.append(cell)
            }
            
            let totalDmg = targets.reduce(0.0) { (prev, curr) -> Double in
                prev + curr.value
            }
            targetHeroes.append(DataRowCell(content: AnyView(Text(String(totalDmg))), width: rowWidth))
            
            rows.append(DataRow(sortKey: skillName, cells: targetHeroes))
            
            
        }
        
        // end rows
        
        let dataGrid = DataGrid(columns: columns, rows: rows)
        
        return ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading){
                DataGridView.buildHeader(dataGrid: dataGrid, height: 100)
                DataGridView(dataGrid: dataGrid, showHeader: false)
            }
        }
        .padding()
    }
}

struct DamageTable_Previews: PreviewProvider {
    static var previews: some View {
        DamageTable(selectedPlayer: demoPlayer, players: [demoPlayer])
            .environmentObject(HeroModel())
    }
}
