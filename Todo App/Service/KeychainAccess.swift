//
//  KeychainAccess.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import Foundation
import KeychainAccess

class KeychainAccess {
    private var keychain: Keychain
    static let shared = KeychainAccess()
    
    init() {
        keychain = Keychain(service: "com.blankz.Todo-App")
    }
    
    var token: String? {
        return try? keychain.get("token")
    }
    
    func set(token: String) {
        try? keychain.set(token, key: "token")
    }
    
    func clear() throws {
        try keychain.remove("token")
    }
}
