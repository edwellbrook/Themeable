//
//  Themer.swift
//  Themeable
//
//  Created by Edward Wellbrook on 26/01/2017.
//  Copyright © 2017 Edward Wellbrook. All rights reserved.
//

import Foundation

public final class Themer<T: Theme> {

    private typealias ThemingFn = (_ theme: T) -> Void

    private var notificationToken: NSObjectProtocol? = nil
    private var functions: [ThemingFn] = []
    private unowned var manager: ThemeManager<T>


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

    private func applyFunctions(theme: T) {
        for fn in functions {
            fn(theme)
        }
    }

    public func addThemeable<Item: Themeable>(_ item: Item) where Item.ThemeType == T {
        // apply the current theme
        item.apply(theme: self.manager.theme)

        // store application function
        self.functions.append({ [weak item] theme in
            item?.apply(theme: theme)
        })
    }

}
