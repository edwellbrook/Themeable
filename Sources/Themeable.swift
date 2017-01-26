//
//  Themeable.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import Foundation

internal let ThemeNotification = Notification.Name("ThemeableDidSetTheme")

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

public protocol Themeable: class {

    associatedtype ThemeType: Theme

    func apply(theme: ThemeType)

}
