//
//  Themer.swift
//  Themeable
//
//  Created by Edward Wellbrook on 26/01/2017.
//  Copyright © 2017 Edward Wellbrook. All rights reserved.
//

import Foundation

/// An object for co-ordinating applying Theme changes to Themeables
public final class Themer<T: Theme> {

    /// typealias for the Themeable.apply(theme:) function
    private typealias ThemingFn = (_ theme: T) -> Void

    /// The token for observing Theme change notifications, removed on deinit
    private var notificationToken: NSObjectProtocol? = nil

    /// A list of the Theming functions to be run when a Theme changes
    private var functions: [ThemingFn] = []

    /// The ThemeManager to get Theme notifications from
    private unowned var manager: ThemeManager<T>


    /**
     * Initialize a new Themer and begin observing Theme change notifications
     *
     * - parameter manager: The ThemeManager to get Theme notifications from
     */
    public init(manager: ThemeManager<T>) {
        self.manager = manager
        self.notificationToken = NotificationCenter.default.addObserver(forName: ThemeNotification, object: manager, queue: .main, using: { [unowned self] notification in
            if let theme = notification.userInfo?["theme"] as? T {
                self.applyFunctions(theme: theme)
            }
        })
    }

    deinit {
        if let token = self.notificationToken {
            NotificationCenter.default.removeObserver(token)
        }
    }

    /**
     * Internal function for running the theming functions with a given Theme
     *
     * - parameter theme: The Theme to use in the theming functions
     */
    private func applyFunctions(theme: T) {
        for fn in functions {
            fn(theme)
        }
    }

    /**
     * Register a Themeable object to receive Theme updates
     *
     * - parameter item: The Themeable item to receive Theme updates
     */
    public func addThemeable<Item: Themeable>(_ item: Item) where Item.ThemeType == T {
        // apply the current theme
        item.apply(theme: self.manager.theme)

        // store application function, uses weak reference to item to avoid
        // retain cycle
        self.functions.append({ [weak item] theme in
            item?.apply(theme: theme)
        })
    }

}
