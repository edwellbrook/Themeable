//
//  ThemeManager.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016 Ed Wellbrook. All rights reserved.
//

import Foundation

internal let ThemeNotification = Notification.Name("ThemeableDidSetTheme")

public final class ThemeManager<Theme> {

    public var theme: Theme {
        didSet {
            NotificationCenter.default.post(name: ThemeNotification, object: nil, userInfo: ["theme": self.theme])
        }
    }

    public init(default theme: Theme) {
        // attempt to load theme from storage, and fallback to `theme`
        // would presumably need a way of registering all themes initially and having identifiers :s
        self.theme = theme
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

public protocol Theme {

    var identifier: String { get }

}
