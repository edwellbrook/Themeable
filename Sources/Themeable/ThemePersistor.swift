//
//  ThemePersistor.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/07/2017.
//  Copyright © 2017 Edward Wellbrook. All rights reserved.
//

import Foundation

/// A type that can be used to persist and retrieve theme identifiers
public protocol ThemePersistor {

    /// The function to return the last used theme identifier
    func retreiveThemeId() -> String?

    /// The function to store the current theme identifier
    func saveThemeId(_ identifier: String)

}

extension UserDefaults: ThemePersistor {

    /// Private key for persisting the active Theme in UserDefaults
    private static let CurrentThemeIdentifier = "ThemeableCurrentThemeIdentifier"

    /// Retreive theme identifer from UserDefaults
    public func retreiveThemeId() -> String? {
        return self.string(forKey: UserDefaults.CurrentThemeIdentifier)
    }

    /// Save theme identifer to UserDefaults
    public func saveThemeId(_ identifier: String) {
        self.set(identifier, forKey: UserDefaults.CurrentThemeIdentifier)
    }
    
}
