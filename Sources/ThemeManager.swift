//
//  ThemeManager.swift
//  Themeable
//
//  Created by Edward Wellbrook on 26/01/2017.
//  Copyright © 2017 Edward Wellbrook. All rights reserved.
//

import Foundation

private let CurrentThemeIdentifier = "ThemeableCurrentThemeIdentifier"

public final class ThemeManager<T: Theme> {

    public var theme: T {
        didSet {
            NotificationCenter.default.post(name: ThemeNotification, object: self, userInfo: ["theme": self.theme])

            // save theme for use next launch
            UserDefaults.standard.set(self.theme.identifier, forKey: CurrentThemeIdentifier)
        }
    }


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
