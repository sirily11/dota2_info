// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

import Foundation

// MARK: - Item
struct Item: Codable {
    let hint: [String]?
    let id: Int?
    let img, dname, qual: String?
    let cost: Int?
    let notes: String?
    let cd: Int?
    let lore: String?
    let charges: Int?
}


extension Item{
    static func load(_ filename: String) -> [String: Item] {
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
            return try decoder.decode([String:Item].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Item.self):\n\(error)")
        }
    }
}
