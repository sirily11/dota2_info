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
        playerSlot = db.playerSlot.value
    }
    
    func toDB() -> ChatDB{
        let data = self.dict
        return ChatDB(value: data ?? [])
    }
}

extension PurchaseLog{
    init(from db: PurchaseLogDB) {
        time = db.time.value
        key = db.key
    }
    
    func toDB() -> PurchaseLogDB{
        return PurchaseLogDB(value: self.dict ?? [])
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
        
    }
    
    
    func toDB() -> MatchPlayerDB{
        return MatchPlayerDB(value: self.dict ?? [])
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
    
    func toDB(playerId: String) -> MatchDetailsDB{
        return MatchDetailsDB(value: self.dict ?? [])
    }
}
