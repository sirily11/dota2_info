//
//  HeroModel.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation

let permanentBuffs = [
  "1": "moon_shard",
  "2": "ultimate_scepter",
  "3": "silencer_glaives_of_wisdom",
  "4": "pudge_flesh_heap",
  "5": "legion_commander_duel",
  "6": "tome_of_knowledge",
  "7": "lion_finger_of_death",
  "8": "slark_essence_shift",
  "9": "abyssal_underlord_atrophy_aura",
  "10": "bounty_hunter_jinada",
  "12": "aghanims_shard",
]


class HeroModel: ObservableObject{
    let heroes = DotaHero.load("heroes.json")
    let abilities = Ability.load("abilities.json")
    let items = Item.load("items.json")
    let itemIds = ItemIds.load("item_ids.json")
    let heroAbilities = HeroAbility.load("hero_abilities.json")
    let abilityIds = AbilityIds.load("ability_ids.json")
    
    
    func findBuffById(_ id: String) -> (Ability?, Item?){
        let skillName = permanentBuffs[id]
        if let skillName = skillName{
            let skill = findAbility(abilityName: skillName)
            if let skill = skill {
                return (skill, nil)
            }
            
            if let item = findItemByName(itemName: skillName){
                return (nil, item)
            }
        }
        return (nil, nil)
    }
    
    func findHeroByName(heroName: String, with items: [Int?]) -> MatchHero?{
        let itemsHold: [Item?] = items.map{
            item in
            if let item = item{
                return findItemById(itemId: String(item))
            } else{
                return nil
            }
            
        }
        let hero = heroes.first{h in h.value.name == heroName }?.value
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
    
    
    func findAbility(abilityName: String) -> Ability?{
        return abilities[abilityName]
    }
    
    func findAbilityById(id: String) -> Ability?{
       let abilityName = abilityIds[id]
        if let abilityName = abilityName{
            return findAbility(abilityName: abilityName)
        }
        return nil
    }
    
    func findItemById(itemId: String) -> Item?{
        if let itemName = itemIds[itemId]{
            return items[itemName]
        }
        return nil
    }
    
    func findItemByName(itemName: String) -> Item?{
        return items[itemName]
    }
    
}
