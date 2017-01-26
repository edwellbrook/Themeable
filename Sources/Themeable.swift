//
//  Themeable.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import Foundation

/// The internal Notification.Name for posting Theme change notifications
internal let ThemeNotification = Notification.Name("ThemeableDidSetTheme")

/// A type that can be used to encapsulate theme values and variants
public protocol Theme: Equatable {

    /// The unique identifier for the theme
    var identifier: String { get }

    /// An array of all the available variants for a theme
    static var variants: [Self] { get }

    /// Enforce equatability
    static func ==(lhs: Self, rhs: Self) -> Bool

}

public extension Theme {

    /// The default implmententation for equating two Themes using identifiers
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}

/// A type that can have a Theme applied to it
public protocol Themeable: class {

    /// The Theme that the type can use
    associatedtype ThemeType: Theme

    /**
     * The function used to apply the Theme
     *
     * - parameter theme: The Theme being applied to the type
     */
    func apply(theme: ThemeType)

}
