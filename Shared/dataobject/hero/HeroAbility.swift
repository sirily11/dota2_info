// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let heroAbility = try? newJSONDecoder().decode(HeroAbility.self, from: jsonData)

import Foundation

// MARK: - HeroAbility
struct HeroAbility: Codable {
    let abilities: [String]?
    let talents: [Talent]?
}

// MARK: - Talent
struct Talent: Codable {
    let name: String?
    let level: Int?
}


extension HeroAbility{
    static func load(_ filename: String) -> [String: HeroAbility] {
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
            return try decoder.decode([String:HeroAbility].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(HeroAbility.self):\n\(error)")
        }
    }
}
