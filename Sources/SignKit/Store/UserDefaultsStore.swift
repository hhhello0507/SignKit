import Foundation

public struct UserDefaultsStore {
    
    public static let shared = UserDefaultsStore()
    
    public let userDefaults: UserDefaults
    
    public init(_ userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func set(_ value: String?, for key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    public func read(key: String) throws -> String {
        if let data = userDefaults.string(forKey: key) {
            return data
        } else {
            throw UserDefaultsError.keyDoesNotExist
        }
    }
    
    public func delete(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
