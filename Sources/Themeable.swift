//
//  Themeable.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import Foundation

internal let ThemeNotification = Notification.Name("ThemeableDidSetTheme")
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


public final class Themer<T: Theme> {

    private var notificationToken: NSObjectProtocol? = nil
    private var functions: [FuncBox<T>] = []
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
            fn.apply(theme)
        }
    }

    public func addThemeable<Item: Themeable>(_ item: Item) where Item.ThemeType == T {
        // apply the current theme
        item.apply(theme: self.manager.theme)

        // box and store application function
        let boxedFn = FuncBox<T>({ [weak item] theme in
            item?.apply(theme: theme)
        })
        self.functions.append(boxedFn)
    }

}

private final class FuncBox<T: Theme> {

    typealias ThemingFn = (_ theme: T) -> Void

    let apply: ThemingFn

    init(_ fn: @escaping ThemingFn) {
        self.apply = fn
    }
}

public protocol Themeable: class {

    associatedtype ThemeType: Theme

    func apply(theme: ThemeType)

}

public protocol Theme: Equatable {

    var identifier: String { get }
    static var variants: [Self] { get }

    static func ==(lhs: Self, rhs: Self) -> Bool

}

public extension Theme {

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
