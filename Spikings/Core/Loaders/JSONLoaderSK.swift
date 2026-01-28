import Foundation

class JSONLoaderSK {
    static func load<T: Decodable>(_ filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Failed to locate \(filename).json in bundle.")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(filename).json from bundle.")
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            print("Failed to decode \(filename).json")
            return nil
        }
        
        return decoded
    }
}
