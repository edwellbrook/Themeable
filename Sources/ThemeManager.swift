//
//  ThemeManager.swift
//  Themeable
//
//  Created by Edward Wellbrook on 26/01/2017.
//  Copyright © 2017 Edward Wellbrook. All rights reserved.
//

import Foundation

/// Internal key for persisting the last used Theme in UserDefaults
private let CurrentThemeIdentifier = "ThemeableCurrentThemeIdentifier"

/// The class for managing Theme state and persistence
public final class ThemeManager<T: Theme> {

    /// The theme currently in use
    public var theme: T {

        didSet {
            NotificationCenter.default.post(name: ThemeNotification, object: self, userInfo: ["theme": self.theme])

            // save theme for use next launch
            UserDefaults.standard.set(self.theme.identifier, forKey: CurrentThemeIdentifier)
        }

    }

    /**
     * Initialize a ThemeManager with a default Theme. The manager will use the
     * last used theme and fallback to the default if one isn't available or if
     * `forceDefault` was used.
     *
     * - parameter default:      The default theme to use and fall back to
     * - parameter forceDefault: Force the manager to use the default instead of
     *                           loading the last used from storage
     */
    public init(default theme: T, forceDefault: Bool = false) {
        guard forceDefault == false, let themeId = UserDefaults.standard.string(forKey: CurrentThemeIdentifier) else {
            self.theme = theme
            return
        }

        let themeWithId: T? = T.variants.first(where: { theme in
            theme.identifier == themeId
        })

        self.theme = themeWithId ?? theme
    }

}
