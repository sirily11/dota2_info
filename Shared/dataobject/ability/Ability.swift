// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ability = try? newJSONDecoder().decode(Ability.self, from: jsonData)

import Foundation

// MARK: - Ability
struct Ability: Codable {
    let dname, dmgType, bkbpierce: String?
    let desc: String?
    let img: String?

    enum CodingKeys: String, CodingKey {
        case dname
        case dmgType = "dmg_type"
        case bkbpierce, desc, img
    }
}


extension Ability{
    static func load(_ filename: String) -> [String: Ability] {
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
            return try decoder.decode([String:Ability].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Ability.self):\n\(error)")
        }
    }
}
