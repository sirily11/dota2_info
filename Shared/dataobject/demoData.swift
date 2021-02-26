//
//  demoData.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/26/21.
//

import Foundation


let demoChats = [
    Chat(time: 164, type: ChatEnum.chat.rawValue, key: "Hello World", unit: "Bard", slot: 5, playerSlot: 1),
    Chat(time: 200, type: ChatEnum.chat.rawValue, key: "Hello World", unit: "Bard", slot: 5, playerSlot: 1)
]

let demoAbilityTargets = ["pugna_decrepify": ["npc_dota_hero_windrunner": 8], "pugna_life_drain": ["npc_dota_hero_windrunner": 8]]

let demoAbilityUses = ["pugna_nether_ward": 40, "pugna_decrepify": 53,
                    "pugna_nether_blast": 50,"pugna_life_drain": 33]

let demoDamageTargets: [String: [String: Double]] = ["null": ["npc_dota_hero_earthshaker": 667, "npc_dota_hero_windrunner": 390, "npc_dota_hero_ursa": 43],
                 "pugna_nether_ward": [  "npc_dota_hero_earthshaker": 8496,
                                                                                                                                        "npc_dota_hero_windrunner": 4497,] ]


let demoPurchaseLogs = [PurchaseLog(time: 100, key: "stormcrafter") ]



let demoPlayer = PlayerMatch(matchID: 5840322763, playerSlot: 1, abilityUpgradesArr: [5347,5345,5347,5346,5347,5348,5347,5345,5345,5949,5345,5348,5346,5346,6352,6346,5348,6534,7106], accountID: 1, assists: 1, permanentBuffs: [PermanentBuff(permanentBuff: 12, stackCount: 2)], backpack0: 0, backpack1: 0, backpack2: 0, backpack3: 0, deaths: 2, denies: 6, gold: 7696, goldPerMin: 1008, goldSpent: 23155, heroDamage: 27079, heroHealing: 696, heroID: 68, item0: 29, item1: 29, item2: 40, item3: 604, item4: 92, item5: 235, itemNeutral: 212, kills: 10, lastHits: 103, leaverStatus: 0, level: 28, netWorth: 30006,   partyID: 4, partySize: 2, towerDamage: 14405, xpPerMin: 1329, personaname: "hhhh", radiantWin: true,  startTime: 1613542889, duration: 1784, cluster: 151, lobbyType: 0, gameMode: 23, isContributor: false, patch: 5, region: 5, isRadiant: true, win: 1, lose: 0, totalGold: 35561, totalXP: 39515, kda: 0, abandons:0, rankTier: 51, abilityTargets: demoAbilityTargets, abilityUses: demoAbilityUses, damageTargets: demoDamageTargets, goldT: [0, 100, 200, 300], lhT: [0, 10, 20, 30], xpT: [0, 100, 200, 300], purchaseLog:demoPurchaseLogs, killedBy: ["npc_dota_hero_earthshaker" : 3], times: [0, 60, 120, 180], teamfightParticipation: 0.43, itemUsage: nil)


let demoMatch = MatchDetails(matchID: 5840322763, barracksStatusDire: 63, barracksStatusRadiant: 0, cluster: 0, direScore: 37, duration: 1784, engine: 1, firstBloodTime: 19, gameMode: 23, humanPlayers: 10, leagueid: 0, lobbyType: 0, matchSeqNum: 4914938039, negativeVotes: 0, positiveVotes: 0, radiantScore: 9, radiantWin: false, skill: 1, startTime: 1613542889, towerStatusDire: 1974, towerStatusRadiant: 0, replaySalt: 1171182118, seriesID: 0, seriesType: 0, players: [demoPlayer], radiantGoldAdv: [0, 404, 100, -100], radiantXPAdv: [400, 300, 100, -100], chat: demoChats, patch: 0, region: 5, replayURL: "http://replay151.valve.net/570/5840322763_1171182118.dem.bz2")
