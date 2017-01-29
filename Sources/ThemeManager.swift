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

    /// A list of observers to be notified when the theme changes
    internal var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    /// The currently active theme
    public var activeTheme: T {

        didSet {
            self.updateObservers()

            // save theme for use next launch
            UserDefaults.standard.set(self.activeTheme.identifier, forKey: CurrentThemeIdentifier)
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
            self.activeTheme = theme
            return
        }

        let themeWithId: T? = T.variants.first(where: { theme in
            theme.identifier == themeId
        })

        self.activeTheme = themeWithId ?? theme
    }

    /**
     * Internal function for running the theming functions with a given Theme
     */
    internal func updateObservers() {
        for item in self.observers.allObjects {
            if let observer = item as? ThemeObservable {
                observer.updateTheme()
            }
        }
    }

    /**
     * Register a Themeable object to receive Theme updates
     *
     * - parameter themeable: The Themeable item wanting to receive updates
     */
    public func register<Item: Themeable>(themeable: Item) where Item.ThemeType == T {
        themeable.updateTheme()

        self.observers.add(themeable)
    }

}
