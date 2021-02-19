// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gameMode = try? newJSONDecoder().decode(GameMode.self, from: jsonData)

import Foundation

// MARK: - GameMode
struct GameMode: Codable {
    let id: Int?
    let name: String?
    let balanced: Bool?
    let localized: String?
}


extension GameMode{
    static func load(_ filename: String) -> [String: GameMode] {
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
            return try decoder.decode([String:GameMode].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(GameMode.self):\n\(error)")
        }
    }
}
