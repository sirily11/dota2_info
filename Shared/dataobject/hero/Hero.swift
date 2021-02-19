// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dotaHero = try? newJSONDecoder().decode(DotaHero.self, from: jsonData)

import Foundation

// MARK: - DotaHero
struct DotaHero: Codable {
    let id: Int?
    let name, localizedName, primaryAttr, attackType: String?
    let roles: [String]?
    let img, icon: String?
    let baseHealth: Double?
    let baseHealthRegen: Double?
    let baseMana, baseManaRegen, baseArmor, baseMr: Double?
    let baseAttackMin, baseAttackMax, baseStr, baseAgi: Double?
    let baseInt: Int?
    let strGain, agiGain, intGain: Double?
    let attackRange, projectileSpeed: Double?
    let attackRate: Double?
    let moveSpeed: Double?
    let turnRate: Double?
    let cmEnabled: Bool?
    let legs: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, img, icon
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case legs
    }
}

/**
 HeroID: HeroData
 */
extension DotaHero {    
    static func load(_ filename: String) -> [String: DotaHero] {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([String:DotaHero].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(DotaHero.self):\n\(error)")
        }
    }
}
