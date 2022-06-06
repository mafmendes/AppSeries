//
//  ConfigureDefaults.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 06/06/2022.
//

import Foundation

final class ConfigureDefaults {
    static var defaults: String {
            get {
                // Read from UserDefaults
                return UserDefaults.standard.string(forKey: StorageKeys.searchBarStorageKey.rawValue) ?? ""
            }
            set {
                // Save to UserDefaults
                UserDefaults.standard.set(newValue, forKey: StorageKeys.searchBarStorageKey.rawValue)
            }
        }
}
