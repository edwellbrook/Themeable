//
//  Themeable.swift
//  Themeable
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import Foundation

/// A type that can be used to encapsulate theme values and variants
public protocol Theme: Equatable {

    /// The unique identifier for the theme
    var identifier: String { get }

    /// An array of all the available variants for a theme
    static var variants: [Self] { get }

    /// The shared ThemeManager for a theme
    static var manager: ThemeManager<Self> { get }

}

public extension Theme {

    /// The default implmententation for equating two Themes using identifiers
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}

/// A type that observes Theme changes
public protocol ThemeObservable: class {

    /// The method called when a theme is changed. You generally shouldn't need
    /// to implement this yourself
    func updateTheme()

}

/// A type that can have a Theme applied to it
public protocol Themeable: ThemeObservable {

    /// The Theme that the type can use
    associatedtype ThemeType: Theme


    /// The function used to apply the Theme
    ///
    /// - Parameter theme: The Theme being applied to the type
    func apply(theme: ThemeType)

}

public extension Themeable {

    /// The function for applying a theme after receiving an update.
    func updateTheme() {
        self.apply(theme: Self.ThemeType.manager.activeTheme)
    }

}
