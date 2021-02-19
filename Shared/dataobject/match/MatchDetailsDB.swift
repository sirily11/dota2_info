//
//  MatchDetailsDB.swift
//  dota2_info
//
//  Created by 李其炜 on 2/19/21.
//

import Foundation
import RealmSwift
//let matchID, barracksStatusDire, barracksStatusRadiant, cluster: Int?
//let direScore, duration, engine, firstBloodTime: Int?
//let gameMode, humanPlayers, leagueid, lobbyType: Int?
//let matchSeqNum, negativeVotes, positiveVotes, radiantScore: Int?
//let radiantWin: Bool?
//let skill, startTime, towerStatusDire, towerStatusRadiant: Int?
//let replaySalt, seriesID, seriesType: Int?
//let players: [PlayerMatch]?
//let patch, region: Int?
//let replayURL: String?
class MatchDetailsDB : Object, ObjectKeyIdentifiable{
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var matchID = 0, barracksStatusDire = 0, barracksStatusRadiant = 0, cluster = 0
    @objc dynamic var direScore = 0, duration = 0, engine = 0, firstBloodTime = 0
    @objc dynamic var  gameMode = 0, humanPlayers = 0, leagueid = 0, lobbyType = 0
//    @objc dynamic var
    
}

//var id = UUID()
//
//let matchID, playerSlot: Int?
//let abilityUpgradesArr: [Int]?
//let accountID, assists: Int?
//let permanentBuffs: [PermanentBuff]?
//let backpack0, backpack1, backpack2, backpack3: Int?
//let deaths, denies: Int?
//let gold, goldPerMin: Double?
//let goldSpent, heroDamage, heroHealing: Double?
//let heroID: Int?
//let item0, item1, item2, item3: Int?
//let item4, item5, itemNeutral, kills: Int?
//let lastHits, leaverStatus, level, netWorth: Double?
//let partyID, partySize, towerDamage, xpPerMin: Double?
//let personaname: String?
//let radiantWin: Bool?
//let startTime, duration, cluster, lobbyType: Double?
//let gameMode: Int?
//let isContributor: Bool?
//let patch, region: Int?
//let isRadiant: Bool?
//let win, lose, totalGold, totalXP: Int?
//let kda, abandons, rankTier: Double?
