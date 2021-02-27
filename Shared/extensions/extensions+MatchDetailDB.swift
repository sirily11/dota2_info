//
//  extensions+MatchDetailDB.swift
//  dota2_info
//
//  Created by 李其炜 on 2/19/21.
//

import Foundation
import SwiftUI

//let permanentBuff, stackCount: Int?



extension Chat{
    init(from db: ChatDB){
        type = db.type
        key = db.key
        time = db.time.value
        slot = db.slot.value
        unit = db.unit
        playerSlot = db.playerSlot.value
    }
    
    func toDB() -> ChatDB{
        let data = self.dict
        return ChatDB(value: ["type": type, "key": key, "time": time, "slot": slot, "playerSlot": playerSlot, "unit": unit])
    }
}

extension PurchaseLog{
    init(from db: PurchaseLogDB) {
        time = db.time.value
        key = db.key
    }
    
    func toDB() -> PurchaseLogDB{
        return PurchaseLogDB(value: ["time": time, "key": key])
    }
}

extension PermanentBuff{
    init(from db: PermanentBuffDB){
        permanentBuff = db.permanentBuff.value
        stackCount = db.stackCount.value
    }
    
    
    func toDB() -> PermanentBuffDB{
        
        return PermanentBuffDB(value: self.dict ?? [])
    }
}


extension PlayerMatch{
    
    init(from db: MatchPlayerDB){
        matchID = db.matchID.value
        playerSlot = db.playerSlot.value
        abilityUpgradesArr = db.abilityUpgradesArr.map{ a in a }
        accountID = db.accountID.value
        assists = db.assists.value
        permanentBuffs = db.permanentBuff.map{buff in PermanentBuff(from: buff) }
        backpack0 = db.backpack0.value
        backpack1 = db.backpack1.value
        backpack2 = db.backpack2.value
        backpack3 = db.backpack3.value
        deaths = db.deaths.value
        denies = db.denies.value
        gold = db.gold.value
        goldPerMin = db.goldPerMin.value
        goldSpent = db.goldSpent.value
        heroDamage = db.heroDamage.value
        heroHealing = db.heroHealing.value
        heroID = db.heroID.value
        item0 = db.item0.value
        item1 = db.item1.value
        item2 = db.item2.value
        item3 = db.item3.value
        item4 = db.item4.value
        item5 = db.item5.value
        itemNeutral = db.itemNeutral.value
        kills = db.kills.value
        
        lastHits = db.lastHits.value
        leaverStatus = db.leaverStatus.value
        level = db.level.value
        netWorth = db.netWorth.value
        partyID = db.partyID.value
        partySize = db.partySize.value
        towerDamage = db.towerDamage.value
        xpPerMin = db.xpPerMin.value
        personaname = db.personaname
        radiantWin = db.radiantWin.value
        startTime = db.startTime.value
        duration = db.duration.value
        cluster = db.cluster.value
        lobbyType = db.lobbyType.value
        gameMode = db.gameMode.value
        isContributor = db.isContributor.value
        patch = db.patch.value
        region = db.region.value
        isRadiant = db.isRadiant.value
        win = db.win.value
        lose = db.lose.value
        totalGold = db.totalGold.value
        totalXP = db.totalXP.value
        kda = db.kda.value
        abandons = db.abandons.value
        rankTier = db.rankTier.value
        // v3 property
        abilityTargets = db.abilityTargets?.dictionaryValue() as? [String: [String: Int]]
        
        abilityUses = db.abilityUses?.dictionaryValue() as? [String: Int ]
        
        damageTargets = db.damageTargets?.dictionaryValue() as? [String: [String: Double]]
        
        killedBy = db.killedBy?.dictionaryValue() as? [String: Int]
        
        itemUsage = db.itemUsage?.dictionaryValue() as? [String: Int]
        
        
        goldT = db.goldT.map{ g in g}
        lhT = db.lhT.map{l in l}
        xpT = db.xpT.map{x in x}
        purchaseLog = db.purchaseLog.map{p in PurchaseLog(from: p) }
        times = db.times.map{t in t }
        teamfightParticipation = db.teamfightParticipation.value
        dnT = db.dnT.map{t in t}
    }
    
    
    func toDB() -> MatchPlayerDB{
        
        let data = MatchPlayerDB(value: ["rankTier": rankTier, "abandons": abandons, "kda": kda, "totalXP": totalXP,
                                         "totalGold": totalGold, "lose": lose, "win": win, "isRadiant": isRadiant,
                                         "region": region, "patch": patch, "isContributor": isContributor, "gameMode": gameMode,
                                         "lobbyType": lobbyType, "cluster": cluster, "duration": duration, "startTime": startTime,
                                         "radiantWin": radiantWin, "personaname": personaname, "xpPerMin": xpPerMin, "towerDamage": towerDamage,
                                         "partySize": partySize, "partyID": partyID, "netWorth": netWorth, "level": level, "leaverStatus": leaverStatus,
                                         "lastHits": lastHits, "kills": kills, "itemNeutral": itemNeutral, "item5": item5, "item4": item4, "item3": item3,
                                         "item2": item2, "item1": item1, "item0": item0, "heroID": heroID, "heroHealing": heroHealing, "heroDamage": heroDamage,
                                         "goldSpent": goldSpent, "goldPerMin": goldPerMin, "gold": gold, "denies": denies, "deaths":deaths,"backpack3": backpack3,
                                         "backpack2": backpack2, "backpack1": backpack1, "backpack0": backpack0,"permanentBuffs": permanentBuffs?.map{ p in p.toDB()},
                                         "assists": assists, "accountID": accountID, "abilityUpgradesArr": abilityUpgradesArr, "playerSlot": playerSlot,
                                         "matchID": matchID, "abilityTargets":  toJSONString(dic: abilityTargets), "abilityUses": toJSONString(dic: abilityUses), "damageTargets": toJSONString(dic: damageTargets), "killedBy": toJSONString(dic: killedBy), "itemUsage":toJSONString(dic: itemUsage), "goldT": goldT, "lhT": lhT, "xpT": xpT, "purchaseLog": purchaseLog?.map{p in p.toDB()}, "times": times, "teamfightParticipation": teamfightParticipation, "dnT": dnT])
        return data
    }
    
    var color: Color{
        get {
            if playerSlot ?? 0 < 128{
                return Color.green
            }
            
            return Color.red
        }
    }
    
    
}

extension MatchDetails{
    
    var isParsed: Bool{
        get {
            if chat == nil{
                return false
            }
            
            return true
        }
    }
    
    var skillsColor: Color {
        get {
            switch skill {
            case 2:
                return Color.orange
            case 3:
                return Color.red
            default:
                return Color.blue
            }
        }
    }
    
    var skillsDescription: String {
        get {
            switch skill {
            case 2:
                return "High"
            case 3:
                return "Very High"
            default:
                return "Normal"
            }
        }
    }
    
    
    init(from db: MatchDetailsDB){
        matchID = db.matchID.value
        barracksStatusDire = db.barracksStatusDire.value
        barracksStatusRadiant = db.barracksStatusRadiant.value
        cluster = db.cluster.value
        direScore = db.direScore.value
        duration = db.duration.value
        engine = db.engine.value
        firstBloodTime = db.firstBloodTime.value
        gameMode = db.gameMode.value
        humanPlayers = db.humanPlayers.value
        leagueid = db.leagueid.value
        lobbyType = db.lobbyType.value
        matchSeqNum = db.matchSeqNum.value
        negativeVotes = db.negativeVotes.value
        positiveVotes = db.positiveVotes.value
        radiantScore = db.radiantScore.value
        radiantWin = db.radiantWin.value
        skill = db.skill.value
        startTime = db.startTime.value
        towerStatusDire = db.towerStatusDire.value
        towerStatusRadiant = db.towerStatusRadiant.value
        replaySalt = db.replaySalt.value
        seriesID = db.seriesID.value
        seriesType = db.seriesType.value
        inDB = true
        players = db.players.map{
            player in
            PlayerMatch(from: player)
        }
        patch  = db.patch.value
        region = db.region.value
        replayURL = db.replayURL
        chat = db.chat.map{ c in Chat(from: c)}
        radiantGoldAdv = db.radiantGoldAdv.map{v in v}
        radiantXPAdv = db.radiantXPAdv.map{ v in v}
        
    }
    
    func toDB(playerId: String?) -> MatchDetailsDB{
        let foundPlayer = self.players?.first{
            p in
            String(p.accountID ?? 0) == playerId
        }
        
        let playerIdToStore = foundPlayer != nil ? playerId : ""
        
        let data = MatchDetailsDB(value: ["replayURL": replayURL, "region": region, "patch": patch, "players": players?.map{p in p.toDB() }, "seriesType": seriesType,
                                          "seriesID": seriesID, "replaySalt": replaySalt, "towerStatusRadiant": towerStatusRadiant, "towerStatusDire": towerStatusDire,
                                          "startTime": startTime,"skill": skill, "radiantWin": radiantWin, "radiantScore": radiantScore, "positiveVotes": positiveVotes,
                                          "negativeVotes": negativeVotes, "matchSeqNum": matchSeqNum, "lobbyType": lobbyType, "leagueid": leagueid, "humanPlayers": humanPlayers, "gameMode": gameMode, "firstBloodTime": firstBloodTime, "engine": engine, "duration": duration,
                                          "direScore": direScore, "cluster": cluster, "barracksStatusRadiant": barracksStatusRadiant, "barracksStatusDire": barracksStatusDire, "matchID": matchID, "playerId": playerIdToStore, "chat": chat?.map{c in c.toDB() }, "radiantGoldAdv": radiantGoldAdv, "radiantXPAdv": radiantXPAdv
        ])
        
        return data
    }
}
