import Foundation

public extension JSONDecoder {
    /// Catches DecodingErrors and converts them into more descriptive errors before re-throwing them.
    func decodeCleaned<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        do {
            return try self.decode(type, from: data)
        } catch let error as DecodingError {
            throw NetworkingError.unableToDecode(String(describing: type), error)
        } catch {
            throw error
        }
    }
}