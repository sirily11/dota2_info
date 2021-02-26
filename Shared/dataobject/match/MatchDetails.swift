// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchDetail = try? newJSONDecoder().decode(MatchDetail.self, from: jsonData)

import Foundation

// MARK: - MatchDetails
struct MatchDetails: Codable {
    let matchID, barracksStatusDire, barracksStatusRadiant, cluster: Int?
    let direScore, duration, engine, firstBloodTime: Int?
    let gameMode, humanPlayers, leagueid, lobbyType: Int?
    let matchSeqNum, negativeVotes, positiveVotes, radiantScore: Int?
    let radiantWin: Bool?
    let skill, startTime, towerStatusDire, towerStatusRadiant: Int?
    let replaySalt, seriesID, seriesType: Int?
    let players: [PlayerMatch]?
    let radiantGoldAdv: [Int]?
    let radiantXPAdv: [Int]?
    let chat: [Chat]?
    let patch, region: Int?
    let replayURL: String?
    var inDB = false

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case barracksStatusDire = "barracks_status_dire"
        case barracksStatusRadiant = "barracks_status_radiant"
        case cluster
        case direScore = "dire_score"
        case duration, engine
        case firstBloodTime = "first_blood_time"
        case gameMode = "game_mode"
        case humanPlayers = "human_players"
        case leagueid
        case lobbyType = "lobby_type"
        case matchSeqNum = "match_seq_num"
        case negativeVotes = "negative_votes"
        case positiveVotes = "positive_votes"
        case radiantScore = "radiant_score"
        case radiantWin = "radiant_win"
        case skill
        case startTime = "start_time"
        case towerStatusDire = "tower_status_dire"
        case towerStatusRadiant = "tower_status_radiant"
        case replaySalt = "replay_salt"
        case seriesID = "series_id"
        case seriesType = "series_type"
        case players, patch, region
        case replayURL = "replay_url"
        case chat
        case radiantGoldAdv = "radiant_gold_adv"
        case radiantXPAdv = "radiant_xp_adv"
    }
}

// MARK - Chat
struct Chat: Codable {
    let time: Int?
    let type, key, unit: String?
    let slot, playerSlot: Int?

    enum CodingKeys: String, CodingKey {
        case time, type, key, slot, unit
        case playerSlot = "player_slot"
    }
}


// MARK: - Player
struct PlayerMatch: Codable, Identifiable {
    var id = UUID()
    
    let matchID, playerSlot: Int?
    let abilityUpgradesArr: [Int]?
    let accountID, assists: Int?
    let permanentBuffs: [PermanentBuff]?
    let backpack0, backpack1, backpack2, backpack3: Int?
    let deaths, denies: Int?
    let gold, goldPerMin: Double?
    let goldSpent, heroDamage, heroHealing: Double?
    let heroID: Int?
    let item0, item1, item2, item3: Int?
    let item4, item5, itemNeutral, kills: Int?
    let lastHits, leaverStatus, level, netWorth: Double?
    let partyID, partySize, towerDamage, xpPerMin: Double?
    let personaname: String?
    let radiantWin: Bool?
    let startTime, duration, cluster, lobbyType: Double?
    let gameMode: Int?
    let isContributor: Bool?
    let patch, region: Int?
    let isRadiant: Bool?
    let win, lose, totalGold, totalXP: Int?
    let kda, abandons, rankTier: Double?
    /**
     Skill name: {
        "heroname": number_of_usages
     }
     */
    let abilityTargets: [String: [String: Int]]?
    let abilityUses: [String: Int]?
    /**
     Skill name?: {
        heroname: damage
     }
        null means regular attack
     */
    let damageTargets: [String: [String: Double]]?
    let goldT: [Int]?
    let lhT: [Int]?
    let xpT: [Int]?
    let purchaseLog: [PurchaseLog]?
    /**
    Name: Number of kills
     */
    let killedBy: [String: Int]?
    let times: [Int]?
    let teamfightParticipation: Double?
    let itemUsage: [String: Int]?
    

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case playerSlot = "player_slot"
        case abilityUpgradesArr = "ability_upgrades_arr"
        case accountID = "account_id"
        case assists
        case permanentBuffs = "permanent_buffs"
        case backpack0 = "backpack_0"
        case backpack1 = "backpack_1"
        case backpack2 = "backpack_2"
        case backpack3 = "backpack_3"
        case deaths, denies, gold
        case goldPerMin = "gold_per_min"
        case goldSpent = "gold_spent"
        case heroDamage = "hero_damage"
        case heroHealing = "hero_healing"
        case heroID = "hero_id"
        case item0 = "item_0"
        case item1 = "item_1"
        case item2 = "item_2"
        case item3 = "item_3"
        case item4 = "item_4"
        case item5 = "item_5"
        case itemNeutral = "item_neutral"
        case kills
        case lastHits = "last_hits"
        case leaverStatus = "leaver_status"
        case level
        case netWorth = "net_worth"
        case partyID = "party_id"
        case partySize = "party_size"
        case towerDamage = "tower_damage"
        case xpPerMin = "xp_per_min"
        case personaname
        case radiantWin = "radiant_win"
        case startTime = "start_time"
        case duration, cluster
        case lobbyType = "lobby_type"
        case gameMode = "game_mode"
        case isContributor = "is_contributor"
        case patch, region, isRadiant, win, lose, times
        case totalGold = "total_gold"
        case totalXP = "total_xp"
        case kda, abandons
        case rankTier = "rank_tier"
        case abilityTargets = "ability_targets"
        case abilityUses = "ability_uses"
        case goldT = "gold_t"
        case damageTargets = "damage_targets"
        case killedBy = "killed_by"
        case lhT = "lh_t"
        case xpT = "xp_t"
        case purchaseLog = "purchase_log"
        case teamfightParticipation = "teamfight_participation"
        case itemUsage = "item_usage"
    }
}

// MARK: - PurchaseLog
struct PurchaseLog: Codable {
    let time: Int?
    let key: String?
}


// MARK: - Benchmarks
struct Benchmarks: Codable {
    let goldPerMin, xpPerMin, killsPerMin, lastHitsPerMin: [String: Double]?
    let heroDamagePerMin, heroHealingPerMin, towerDamage, stunsPerMin: [String: Double]?
    let lhten: Lhten?

    enum CodingKeys: String, CodingKey {
        case goldPerMin = "gold_per_min"
        case xpPerMin = "xp_per_min"
        case killsPerMin = "kills_per_min"
        case lastHitsPerMin = "last_hits_per_min"
        case heroDamagePerMin = "hero_damage_per_min"
        case heroHealingPerMin = "hero_healing_per_min"
        case towerDamage = "tower_damage"
        case stunsPerMin = "stuns_per_min"
        case lhten
    }
}

// MARK: - Lhten
struct Lhten: Codable {
}

// MARK: - PermanentBuff
struct PermanentBuff: Codable {
    let permanentBuff, stackCount: Int?

    enum CodingKeys: String, CodingKey {
        case permanentBuff = "permanent_buff"
        case stackCount = "stack_count"
    }
}




extension MatchDetails{
    func toAbstractMatch(playerID: String) -> DotaMatchElement{
        var foundPlayer = 0
        var foundHero = 0
        var foundKills = 0
        var foundDeaths = 0
        var foundAssists = 0
        var foundPartySize = 0.0
        
        if let players = players{
            for  player in players{
                if let accountID = player.accountID{
                    if String(accountID) == playerID{
                        foundKills = player.kills ?? 0
                        foundDeaths = player.deaths ?? 0
                        foundAssists = player.assists ?? 0
                        foundHero = player.heroID ?? 0
                        foundPartySize = player.partySize ?? 0
                        foundPlayer = player.playerSlot ?? 0
                        break
                    }
                }
               
            }
        }
        

        
        return DotaMatchElement(id: matchID, playerSlot: foundPlayer, radiantWin: radiantWin, duration: duration, gameMode: gameMode, lobbyType: lobbyType, heroID: foundHero, startTime: startTime, version: nil, kills: Int(foundKills), deaths:  Int(foundDeaths), assists:  Int(foundAssists), skill: skill, partySize:  Int(foundPartySize), heroes: nil, inDB: inDB)
    }
}
