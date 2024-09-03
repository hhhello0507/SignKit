import Foundation

public struct Sign {
    
    public static let shared = Sign()
    
    public let store: UserDefaultsStore
    
    public init(store: UserDefaultsStore = .shared) {
        self.store = store
    }
    
    public func login(
        id: String,
        password: String,
        accessToken: String?,
        refreshToken: String?
    ) {
        store.set(id, for: "id")
        KeychainStore.set(password, for: id)
        store.set(accessToken, for: "accessToken")
        KeychainStore.set(refreshToken, for: "refreshToken")
    }
    
    public func logout() {
        if let id {
            KeychainStore.delete(key: id)
        }
        store.delete(key: "id")
        store.delete(key: "accessToken")
        KeychainStore.delete(key: "refreshToken")
    }
    
    public func reissue(_ accessToken: String?) {
        store.set(accessToken, for: "accessToken")
    }
    
    public var isLoggedIn: Bool {
        id != nil
    }
    
    public var id: String? {
        try? store.read(key: "id")
    }
    
    public var password: String? {
        guard let id else { return nil }
        return try? KeychainStore.read(key: id)
    }
    
    public var accessToken: String? {
        try? store.read(key: "accessToken")
    }
    
    public var refreshToken: String? {
        try? KeychainStore.read(key: "refreshToken")
    }
}
