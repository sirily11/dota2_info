// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dotaMatch = try? newJSONDecoder().decode(DotaMatch.self, from: jsonData)

import Foundation

// MARK: - DotaMatchElement
struct DotaMatchElement: Codable, Identifiable {
    let id, playerSlot: Int?
    let radiantWin: Bool?
    let duration, gameMode, lobbyType, heroID: Int?
    let startTime, version, kills, deaths: Int?
    let assists, skill, partySize: Int?
    let heroes: Heroes?
    var inDB = false

    enum CodingKeys: String, CodingKey {
        case id = "match_id"
        case playerSlot = "player_slot"
        case radiantWin = "radiant_win"
        case duration
        case gameMode = "game_mode"
        case lobbyType = "lobby_type"
        case heroID = "hero_id"
        case startTime = "start_time"
        case version, kills, deaths, assists, skill
        case partySize = "party_size"
        case heroes
    }
}

// MARK: - Heroes
struct Heroes: Codable {
    let playerSlot: PlayerSlot?

    enum CodingKeys: String, CodingKey {
        case playerSlot = "player_slot"
    }
}

// MARK: - PlayerSlot
struct PlayerSlot: Codable {
    let accountID, heroID, playerSlot: Int?

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case heroID = "hero_id"
        case playerSlot = "player_slot"
    }
}

typealias DotaMatch = [DotaMatchElement]
