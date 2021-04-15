//
//  KeychainManager.swift
//  KeyChainTutorial
//
//  Created by 이재용 on 2021/04/15.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var password: String
}

final class KeychainManager {
    //MARK: - Shared instance
    static let shared = KeychainManager()
    private init() { }

    //MARK: - Keychain
    
    private let account = "Service"
    private let service = Bundle.main.bundleIdentifier
    private lazy var query: [CFString: Any]? = {
        guard let service = self.service else { return nil }
        return [kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account]
    }()

    func createUser(_ user: User) -> Bool {
        guard let data = try? JSONEncoder().encode(user),
              let service = self.service else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecAttrGeneric: data]

        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
}
