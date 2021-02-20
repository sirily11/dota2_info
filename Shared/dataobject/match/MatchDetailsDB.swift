//
//  MatchDetailsDB.swift
//  dota2_info
//
//  Created by 李其炜 on 2/19/21.
//

import Foundation
import RealmSwift

class MatchDetailsDB: Object {
    @objc dynamic var _id = ObjectId.generate()
    /// Who store this match
    @objc dynamic var playerId: String = ""

    let matchID = RealmOptional<Int>()
    let barracksStatusDire = RealmOptional<Int>()
    let barracksStatusRadiant = RealmOptional<Int>()
    let cluster = RealmOptional<Int>()
    let direScore = RealmOptional<Int>(), duration = RealmOptional<Int>(), engine = RealmOptional<Int>(), firstBloodTime = RealmOptional<Int>()
    let gameMode = RealmOptional<Int>(), humanPlayers = RealmOptional<Int>(), leagueid = RealmOptional<Int>(), lobbyType = RealmOptional<Int>()
    let matchSeqNum = RealmOptional<Int>(), negativeVotes = RealmOptional<Int>(), positiveVotes = RealmOptional<Int>(), radiantScore = RealmOptional<Int>()
    let radiantWin = RealmOptional<Bool>()
    let skill = RealmOptional<Int>(), startTime = RealmOptional<Int>(), towerStatusDire = RealmOptional<Int>(), towerStatusRadiant = RealmOptional<Int>()
    let patch = RealmOptional<Int>(), region = RealmOptional<Int>()
    @objc dynamic var replayURL: String? = ""
    let replaySalt = RealmOptional<Int>(), seriesID = RealmOptional<Int>(), seriesType = RealmOptional<Int>()
    let players = List<MatchPlayerDB>()
}

class MatchPlayerDB: Object {
    let matchID = RealmOptional<Int>(), playerSlot = RealmOptional<Int>()
    let abilityUpgradesArr = List<Int>()
    let accountID = RealmOptional<Int>(), assists = RealmOptional<Int>()
    let backpack0 = RealmOptional<Int>(), backpack1 = RealmOptional<Int>(), backpack2 = RealmOptional<Int>(), backpack3 = RealmOptional<Int>()
    let deaths = RealmOptional<Int>(), denies = RealmOptional<Int>()
    let gold = RealmOptional<Double>()
    let goldPerMin = RealmOptional<Double>()
    let goldSpent = RealmOptional<Double>()
    let heroDamage = RealmOptional<Double>()
    let heroHealing = RealmOptional<Double>()
    let heroID = RealmOptional<Int>(), item0  = RealmOptional<Int>(), item1 = RealmOptional<Int>(), item2 = RealmOptional<Int>(), item3 = RealmOptional<Int>(), item4 = RealmOptional<Int>(), item5 = RealmOptional<Int>(), itemNeutral = RealmOptional<Int>(), kills = RealmOptional<Int>()
    let lastHits = RealmOptional<Double>(), leaverStatus = RealmOptional<Double>(), level = RealmOptional<Double>(), netWorth = RealmOptional<Double>()
    let partyID = RealmOptional<Double>(), partySize = RealmOptional<Double>(), towerDamage = RealmOptional<Double>(), xpPerMin = RealmOptional<Double>()
    @objc dynamic var personaname: String? = ""
    let radiantWin = RealmOptional<Bool>(), isRadiant = RealmOptional<Bool>(), isContributor = RealmOptional<Bool>()
    let startTime = RealmOptional<Double>(), duration = RealmOptional<Double>(), cluster = RealmOptional<Double>(), lobbyType = RealmOptional<Double>()
    let gameMode = RealmOptional<Int>(), patch = RealmOptional<Int>(), region = RealmOptional<Int>(), win = RealmOptional<Int>(), lose = RealmOptional<Int>(), totalGold = RealmOptional<Int>(), totalXP = RealmOptional<Int>()
    let kda = RealmOptional<Double>(), abandons = RealmOptional<Double>(), rankTier = RealmOptional<Double>()
    let permanentBuff = List<PermanentBuffDB>()
}

class PermanentBuffDB: Object {
    let permanentBuff = RealmOptional<Int>(), stackCount = RealmOptional<Int>()
}
