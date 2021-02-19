//
//  MatchHero.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation

/**
 This class holds hero's info, hero's abilities' info and item's info
 */
struct MatchHero{
    var items: [Item?]
    var ability: [Ability]
    var heroData: DotaHero
}
