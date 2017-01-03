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
            NotificationCenter.default.post(name: ThemeNotification, object: nil, userInfo: ["theme": self.theme])

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

public final class Themer<T: Themeable> {

    private var notificationToken: NSObjectProtocol? = nil
    private weak var themeable: T?

    public weak var manager: ThemeManager<T.ThemeType>!


    public init(manager: ThemeManager<T.ThemeType>) {
        self.manager = manager
        self.notificationToken = NotificationCenter.default.addObserver(forName: ThemeNotification, object: nil, queue: .main, using: self.notificationHandler)
    }

    deinit {
        if let token = self.notificationToken {
            NotificationCenter.default.removeObserver(token)
        }
    }

    private func notificationHandler(notification: Notification) {
        if let theme = notification.userInfo?["theme"] as? T.ThemeType {
            self.themeable?.apply(theme: theme)
        }
    }

    public func theme(_ themeable: T) {
        self.themeable = themeable
        self.themeable?.apply(theme: self.manager.theme)
    }

}

public protocol Themeable: class {

    associatedtype ThemeType: Theme

    var themer: Themer<Self> { get }

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
