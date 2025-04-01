//
//  Cache.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-31.
//


import Foundation
import Combine

class Cache<T: Codable> {
    let key: String
    let storage: UserDefaults
    private(set) var subject = CurrentValueSubject<T?, Never>(nil)

    var currentValue: T? {
        subject.value
    }

    init(key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.storage = storage
        self.subject.send(getValue())
    }

    func getValue() -> T? {
        guard let data = storage.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func saveValue(_ newValue: T) {
        self.subject.send(newValue)
        let data = try? JSONEncoder().encode(newValue)
        storage.set(data, forKey: key)
    }

    func clearCache() {
        subject.send(nil)
        storage.removeObject(forKey: key)
    }
}
