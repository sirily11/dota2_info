import Foundation

struct GameRegion {
    static func load(_ filename: String) -> [String: String] {
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
            return try decoder.decode([String:String].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(String.self):\n\(error)")
        }
    }
}
