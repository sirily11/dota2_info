//
//  HeroModel.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation

class HeroModel: ObservableObject{
    let heroes = DotaHero.load("heroes.json")
    let abilities = Ability.load("abilities.json")
    let items = Item.load("items.json")
    let itemIds = ItemIds.load("item_ids.json")
    let heroAbilities = HeroAbility.load("hero_abilities.json")
    let abilityIds = AbilityIds.load("ability_ids.json")
    
    
    /**
    Find Hero by hero id. This also requires items' id so that it will return an object with items
     */
    func findHeroById(_ heroId: String, with items: [Int?]) -> MatchHero?{
        let itemsHold: [Item?] = items.map{
            item in
            if let item = item{
                return findItemById(itemId: String(item))
            } else{
                return nil
            }
            
        }
        
        let hero = findDotaHeroById(heroId)
        
        if let hero = hero{
            let abilityName = findHeroAbilities(heroName: hero.name!)
            if let abilityName = abilityName{
                let abilities: [Ability] = abilityName.abilities!.map{
                    ability in
                    findAbility(abilityName: ability)!
                }
                
                return MatchHero(items: itemsHold , ability: abilities, heroData: hero)
            }
          
        }
        
        return nil
    }
    
    private func findDotaHeroById(_ heroId: String) -> DotaHero?{
        return heroes[heroId]
    }
    
    /**
     Hero name should start with npc
     */
    private func findHeroAbilities(heroName: String) -> HeroAbility?{
       return heroAbilities[heroName]
    }
    
    
    private func findAbility(abilityName: String) -> Ability?{
        return abilities[abilityName]
    }
    
    func findAbilityById(id: String) -> Ability?{
       let abilityName = abilityIds[id]
        if let abilityName = abilityName{
            return findAbility(abilityName: abilityName)
        }
        return nil
    }
    
    private func findItemById(itemId: String) -> Item?{
        if let itemName = itemIds[itemId]{
            return items[itemName]
        }
        return nil
    }
    
}
