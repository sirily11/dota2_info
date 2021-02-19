// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dotaPlayer = try? newJSONDecoder().decode(DotaPlayer.self, from: jsonData)

import Foundation

// MARK: - DotaPlayer
struct DotaPlayer: Codable {
    let soloCompetitiveRank, competitiveRank: Int?
    let rankTier, leaderboardRank: Int?
    let mmrEstimate: MmrEstimate?
    let profile: Profile?

    enum CodingKeys: String, CodingKey {
//        case trackedUntil = "tracked_until"
        case soloCompetitiveRank = "solo_competitive_rank"
        case competitiveRank = "competitive_rank"
        case rankTier = "rank_tier"
        case leaderboardRank = "leaderboard_rank"
        case mmrEstimate = "mmr_estimate"
        case profile
    }
}

// MARK: - MmrEstimate
struct MmrEstimate: Codable {
    let estimate, stdDev, n: Int?
}

// MARK: - Profile
struct Profile: Codable {
    let accountID: Int?
    let personaname, name: String?
    let plus: Bool?
    let cheese: Int?
    let steamid, avatar, avatarmedium, avatarfull: String?
    let profileurl, lastLogin, loccountrycode: String?
    let isContributor: Bool?

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case personaname, name, plus, cheese, steamid, avatar, avatarmedium, avatarfull, profileurl
        case lastLogin = "last_login"
        case loccountrycode
        case isContributor = "is_contributor"
    }
}
