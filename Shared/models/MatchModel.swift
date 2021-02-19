//
//  MatchModel.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation
import SwiftUI

class MatchModel : ObservableObject{
    let matchAbstractURL = "https://api.opendota.com/api/players/"
    let searchURL = "https://api.opendota.com/api/matches/"
    
    @Published var selectedPlayer: String?
    
    @Published var heroData = DotaHero.load("heroes.json")
    @Published var regionData = GameRegion.load("region.json")
    @Published var gameModeData = GameMode.load("game_mode.json")
    
    @Published var isLoadingMatches = false
    @Published var matches: [DotaMatchElement] = []
    
    func getHeroById(_ heroId: String) -> DotaHero?{
        return heroData[heroId]
    }
    
    func getRegionById(_ regionId: String) -> String{
        return regionData[regionId] ?? ""
    }
    
    func getGameModeById(_ gameMode: String) -> GameMode?{
        return gameModeData[gameMode]
    }
    
    func findMatchById(_ matchId: String, playerID: String){
        guard let url = URL(string: "\(searchURL)\(matchId)" ) else {
            return
        }
        
        withAnimation{
            isLoadingMatches = true
        }
 
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {
                self.isLoadingMatches = false
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                let match = try JSONDecoder().decode(MatchDetails.self, from: data)
                withAnimation{
                    self.matches = [match.toAbstractMatch(playerID: playerID)]
                    self.isLoadingMatches = false
                }
                } catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    withAnimation{
               
                        self.isLoadingMatches = false
                    }
                }
            
            }
        }.resume()
    }
    
    func findMatchDetailsById(_ matchId: String, playerID: String, completion: @escaping (MatchDetails) -> Void ){
        guard let url = URL(string: "\(searchURL)\(matchId)" ) else {
            return
        }
    
 
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {
                self.isLoadingMatches = false
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                let match = try JSONDecoder().decode(MatchDetails.self, from: data)
                    completion(match)
                } catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                  
                }
            
            }
        }.resume()
    }
    
    func findMatchByPlayer(playerId: String){
        guard let url = URL(string: "\(matchAbstractURL)\(playerId)/recentMatches" ) else {
            return
        }
        
      
        
        withAnimation{
            isLoadingMatches = true
            selectedPlayer = playerId
        }
 
        
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {
                self.isLoadingMatches = false
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                let matches = try JSONDecoder().decode([DotaMatchElement].self, from: data)
                self.matches = matches
                withAnimation{
                   
                    self.isLoadingMatches = false
                }
                } catch{
                    withAnimation{
               
                        self.isLoadingMatches = false
                    }
                }
            
            }
        }.resume()
    }
}

class MockModel: MatchModel{
    override init() {
        super.init()
        matches = [DotaMatchElement(id: 12345, playerSlot: 3, radiantWin: true, duration: 3005, gameMode: 22, lobbyType: 0, heroID: 16, startTime: 1607233132, version: nil, kills: 4, deaths: 7, assists: 29, skill: nil, partySize: 2, heroes: nil) ]
    }
}


//let demoMatch = MatchDetails(matchID: 5840322763, barracksStatusDire: 63, barracksStatusRadiant: 0, cluster: 0, direScore: 37,  duration: 1784, engine: 1, firstBloodTime: 19, gameMode: 23, humanPlayers: 10, leagueid: 0, lobbyType: 0, matchSeqNum: 4914938039, negativeVotes: 0,  positiveVotes: 0, radiantScore: 9, radiantWin: false,  skill: 1, startTime: 1613542889,  towerStatusDire: 1974, towerStatusRadiant: 0, replaySalt: 1171182118, seriesID: 0, seriesType: 0, players: [PlayerMatch(matchID: 5840322763, playerSlot: 130,  abilityUpgradesArr: [5347,5345,5347,5346,5347,5348,5347,5345,5345,5949,5345,5348,5346,5346,6352,6346,5348,6534,7106], kda: 0.3,  accountID: 178510306, assists: 21, backpack0: 0, backpack1: 0, backpack2: 0, backpack3: 0, deaths: 2, denies: 6,gold: 7696, goldPerMin: 1008,  goldSpent: 23155,  heroDamage: 27079, heroHealing: 696,  heroID: 68, item0: 29, item1: 40, item2: 610, item3: 604, item4: 92, item5: 235, itemNeutral: 212,   kills: 10,  lastHits: 103, leaverStatus: 0, level: 28, netWorth: 30006, partyID: 4, partySize: 2, permanentBuffs: [PermanentBuff(permanentBuff: 12, stackCount: 0)],  towerDamage: 14405, xpPerMin: 1329, personaname: "快L7点发财啦", startTime: 1613542889, duration: 1784, cluster: 151, lobbyType: 0, gameMode: 23,  patch: 0, region: 5, isRadiant: false, win: 1, lose: 0, totalGold: 35561, totalXP: 39515, abandons: 0, rankTier: 51 )], patch: 0, region: 5, replayURL: "http://replay151.valve.net/570/5840322763_1171182118.dem.bz2")
//
//

let demoMatch = MatchDetails(matchID: 5840322763, barracksStatusDire: 63, barracksStatusRadiant: 0, cluster: 0, direScore: 37, duration: 1784, engine: 1, firstBloodTime: 19, gameMode: 23, humanPlayers: 10, leagueid: 0, lobbyType: 0, matchSeqNum: 4914938039, negativeVotes: 0, positiveVotes: 0, radiantScore: 9, radiantWin: false, skill: 1, startTime: 1613542889, towerStatusDire: 1974, towerStatusRadiant: 0, replaySalt: 1171182118, seriesID: 0, seriesType: 0, players: [PlayerMatch(matchID: 5840322763, playerSlot: 130, abilityUpgradesArr: [5347,5345,5347,5346,5347,5348,5347,5345,5345,5949,5345,5348,5346,5346,6352,6346,5348,6534,7106], accountID: 178510306, assists: 21, permanentBuffs: [PermanentBuff(permanentBuff: 12, stackCount: 0)], backpack0: 0, backpack1: 0, backpack2: 0, backpack3: 0, deaths: 2, denies: 6, gold: 7696, goldPerMin: 1008, goldSpent: 23155, heroDamage: 27079, heroHealing: 696, heroID: 68, item0: 29, item1: 29, item2: 40, item3: 604, item4: 92, item5: 235, itemNeutral: 212, kills: 10, lastHits: 103, leaverStatus: 0, level: 28, netWorth: 30006, partyID: 4, partySize: 2, towerDamage: 14405, xpPerMin: 1329, personaname: "hhhh", radiantWin: true, startTime: 1613542889, duration: 1784, cluster: 151, lobbyType: 0, gameMode: 23, isContributor: false, patch: 5, region: 5, isRadiant: true, win: 1, lose: 0, totalGold: 35561, totalXP: 39515, kda: 0, abandons:0, rankTier: 51)], patch: 0, region: 5, replayURL: "http://replay151.valve.net/570/5840322763_1171182118.dem.bz2")
